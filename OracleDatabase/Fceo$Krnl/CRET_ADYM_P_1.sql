--------------------------------------------------------
--  DDL for Procedure CRET_ADYM_P
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "FCEO$KRNL"."CRET_ADYM_P" 
   AUTHID CURRENT_USER
AS
   CURSOR c_domain IS
      SELECT DISTINCT domn_name
        FROM APP_DYNAMIC_DOMAIN;

   v_code        VARCHAR2 (50);
   v_sql         VARCHAR2 (4000);
   v_view_name   VARCHAR2 (200);
   v_cnt         NUMBER;
BEGIN
   OPEN c_domain;

   LOOP
      FETCH c_domain INTO v_code;

      EXIT WHEN c_domain%NOTFOUND;

      v_view_name := 'VD#' || v_code;

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
         || 'SELECT REF_CODE, CODE, RWNO, DOMN_DESC '
         || 'FROM APP_DYNAMIC_DOMAIN A '
         || 'WHERE A.DOMN_NAME = '''
         || v_code
         || '''';

      EXECUTE IMMEDIATE v_sql;
   END LOOP;

   CLOSE c_domain;
END;

/
