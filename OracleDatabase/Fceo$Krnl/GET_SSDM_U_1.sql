--------------------------------------------------------
--  DDL for Function GET_SSDM_U
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "FCEO$KRNL"."GET_SSDM_U" (p_shamsi VARCHAR2)
RETURN DATE
IS
    sh_year NUMBER;
    sh_month NUMBER;
    sh_day NUMBER;

    gy NUMBER;
    gm NUMBER;
    gd NUMBER;

    g_day_no NUMBER;
    j_day_no NUMBER;
    j_np NUMBER;
    i NUMBER;

    jalali_month_days SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(31,31,31,31,31,31,30,30,30,30,30,29);
BEGIN
    -- جدا کردن سال، ماه، روز از ورودی
    sh_year  := TO_NUMBER(SUBSTR(p_shamsi,1,4));
    sh_month := TO_NUMBER(SUBSTR(p_shamsi,6,2));
    sh_day   := TO_NUMBER(SUBSTR(p_shamsi,9,2));

    -- تبدیل شمسی به میلادی
    j_day_no := 365*(sh_year - 979) + FLOOR((sh_year - 979)/33)*8 + FLOOR(MOD(sh_year - 979,33)+3)/4;
    FOR i IN 1..sh_month-1 LOOP
        j_day_no := j_day_no + jalali_month_days(i);
    END LOOP;
    j_day_no := j_day_no + sh_day - 1;

    g_day_no := j_day_no + 79;

    gy := 1600 + 400 * FLOOR(g_day_no / 146097);
    g_day_no := MOD(g_day_no, 146097);

    IF g_day_no >= 36525 THEN
        g_day_no := g_day_no - 1;
        gy := gy + 100 * FLOOR(g_day_no/36524);
        g_day_no := MOD(g_day_no,36524);
        IF g_day_no >= 365 THEN
            g_day_no := g_day_no +1;
        END IF;
    END IF;

    gy := gy + 4*FLOOR(g_day_no/1461);
    g_day_no := MOD(g_day_no,1461);

    IF g_day_no >= 366 THEN
        gy := gy + FLOOR((g_day_no-1)/365);
        g_day_no := MOD(g_day_no-1,365);
    END IF;

    -- محاسبه ماه و روز میلادی
    DECLARE
        g_month_days SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(31,28,31,30,31,30,31,31,30,31,30,31);
        leap BOOLEAN;
    BEGIN
        leap := (MOD(gy,4)=0 AND (MOD(gy,100)!=0 OR MOD(gy,400)=0));
        IF leap THEN g_month_days(2) := 29; END IF;

        i := 1;
        LOOP
            EXIT WHEN g_day_no < g_month_days(i);
            g_day_no := g_day_no - g_month_days(i);
            i := i + 1;
        END LOOP;

        gm := i;
        gd := g_day_no + 1;
    END;

    RETURN TO_DATE(gy||'-'||LPAD(gm,2,'0')||'-'||LPAD(gd,2,'0'),'YYYY-MM-DD');
END;

/
