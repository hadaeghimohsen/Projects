--------------------------------------------------------
--  DDL for Function GET_MSDS_U
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "FCEO$KRNL"."GET_MSDS_U" (p_date DATE)
RETURN VARCHAR2
IS
    -- متغیرهای شمسی
    sh_year NUMBER;
    sh_month NUMBER;
    sh_day NUMBER;
    
    -- ثابت‌ها برای الگوریتم تبدیل
    gy NUMBER;
    gm NUMBER;
    gd NUMBER;
    
    g_day_no NUMBER;
    j_day_no NUMBER;
    j_np NUMBER;
    i NUMBER;
    
    jalali_month_days  SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(31,31,31,31,31,31,30,30,30,30,30,29);
BEGIN
    -- تاریخ میلادی
    gy := TO_NUMBER(TO_CHAR(p_date,'YYYY'));
    gm := TO_NUMBER(TO_CHAR(p_date,'MM'));
    gd := TO_NUMBER(TO_CHAR(p_date,'DD'));

    -- الگوریتم تبدیل میلادی به شمسی
    g_day_no := 365 * (gy - 1600) + FLOOR((gy - 1600 + 3) / 4) - FLOOR((gy - 1600 + 99)/100) + FLOOR((gy - 1600 + 399)/400);
    FOR i IN 1..gm-1 LOOP
        g_day_no := g_day_no + CASE i
                                WHEN 1 THEN 31
                                WHEN 2 THEN CASE WHEN MOD(gy,4)=0 AND (MOD(gy,100)!=0 OR MOD(gy,400)=0) THEN 29 ELSE 28 END
                                WHEN 3 THEN 31
                                WHEN 4 THEN 30
                                WHEN 5 THEN 31
                                WHEN 6 THEN 30
                                WHEN 7 THEN 31
                                WHEN 8 THEN 31
                                WHEN 9 THEN 30
                                WHEN 10 THEN 31
                                WHEN 11 THEN 30
                                WHEN 12 THEN 31
                              END;
    END LOOP;
    g_day_no := g_day_no + gd - 1;

    j_day_no := g_day_no - 79;

    j_np := FLOOR(j_day_no / 12053);
    j_day_no := MOD(j_day_no, 12053);

    sh_year := 979 + 33 * j_np + 4 * FLOOR(j_day_no / 1461);
    j_day_no := MOD(j_day_no, 1461);

    IF j_day_no >= 366 THEN
        sh_year := sh_year + FLOOR((j_day_no - 1)/365);
        j_day_no := MOD(j_day_no -1, 365);
    END IF;

    i := 0;
    LOOP
        EXIT WHEN j_day_no < jalali_month_days(i+1);
        j_day_no := j_day_no - jalali_month_days(i+1);
        i := i + 1;
    END LOOP;

    sh_month := i + 1;
    sh_day := j_day_no + 1;

    RETURN TO_CHAR(sh_year) || '/' || LPAD(sh_month,2,'0') || '/' || LPAD(sh_day,2,'0');
END;

/
