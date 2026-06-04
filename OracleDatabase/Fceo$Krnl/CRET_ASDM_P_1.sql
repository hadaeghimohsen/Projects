--------------------------------------------------------
--  DDL for Procedure CRET_ASDM_P
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "FCEO$KRNL"."CRET_ASDM_P" 
   AUTHID CURRENT_USER
AS
   CURSOR c_domain IS
      SELECT DISTINCT code
        FROM APP_STATIC_DOMAIN;

   v_code        VARCHAR2 (20);
   v_sql         VARCHAR2 (4000);
   v_view_name   VARCHAR2 (200);
   v_cnt         NUMBER;
   v_suffix      VARCHAR2 (200);
BEGIN
   OPEN c_domain;

   LOOP
      FETCH c_domain INTO v_code;

      EXIT WHEN c_domain%NOTFOUND;

      -- معادل SUBSTRING(@code, 3, LEN(@code))
      v_suffix := SUBSTR (v_code, 3, LENGTH (v_code));

      v_view_name := 'D$' || v_suffix;

      -- بررسی وجود View
      SELECT COUNT (*)
        INTO v_cnt
        FROM user_views
       WHERE view_name = UPPER (v_view_name);

      -- اگر وجود داشت Drop شود
      IF v_cnt > 0
      THEN
         v_sql := 'DROP VIEW ' || v_view_name;

         EXECUTE IMMEDIATE v_sql;
      END IF;

      -- ساخت View جدید
      v_sql :=
            'CREATE VIEW '
         || v_view_name
         || ' AS '
         || 'SELECT VALU, DOMN_DESC '
         || 'FROM APP_STATIC_DOMAIN A '
         || 'WHERE A.CODE = '''
         || v_code
         || '''';

      EXECUTE IMMEDIATE v_sql;
   END LOOP;

   CLOSE c_domain;
END;

/
