--------------------------------------------------------
--  DDL for Package Body PBLC_COMN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."PBLC_COMN_PKG" AS
/******************************************************************************
   NAME:       PBLC_COMN_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/07/2025      hadaeghi       1. Created this package.
******************************************************************************/

   -- Get Meta data of table columns with return json string
   FUNCTION GMTJ_TCLM_U(p_in CLOB) 
   RETURN CLOB
   IS
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_tablName VARCHAR2(100);
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_tablName := l_in.GET_STRING('TABL_NAME');
      -- The goals and tasks of this function are as follows:
      -- 1. Checking the access required to execute a procedure.
      
      SELECT '{' || LISTAGG(COLUMN_NAME || ': ""', ', ') WITHIN GROUP (ORDER BY COLUMN_ID) || '}' 
        INTO l_out 
        FROM USER_TAB_COLUMNS
       WHERE TABLE_NAME = l_tablName
         AND COLUMN_NAME NOT LIKE 'CRET_%'
         AND COLUMN_NAME NOT LIKE 'MDFY_%'
         AND COLUMN_NAME NOT LIKE 'DEL_%';
      
      -- Serialize برگردوندن به CLOB      
      RETURN l_out;
   EXCEPTION
      WHEN OTHERS THEN
      BEGIN
         l_sqlcode  := SQLCODE;
         l_sqlerrm   := SQLERRM;
         l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         SELECT 
           JSON_OBJECT(
               'rspncode' VALUE '-1',
               'rspndesc' VALUE 'failed',
               'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
               'sqlerrm' VALUE l_sqlerrm,
               'sqlcode' VALUE l_sqlcode,
               'sqlbacktrac' VALUE l_backtrac
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;
   
   FUNCTION STR_FRMT_U (p_tmpl  IN VARCHAR2,p_parm IN SYS.ODCIVARCHAR2LIST) 
   RETURN VARCHAR2 
   IS
      v_result VARCHAR2(32767) := p_tmpl;
      v_val    VARCHAR2(4000);
      v_fmt    VARCHAR2(100);
      v_pat    VARCHAR2(100);
      v_input  VARCHAR2(4000);

      FUNCTION detect_type(p_value VARCHAR2) RETURN VARCHAR2 IS
      BEGIN
        IF p_value IS NULL THEN
            RETURN 'NULL';
        ELSIF REGEXP_LIKE(p_value, '^-?\d+(\.\d+)?$') THEN
            RETURN 'NUMBER';
        ELSIF REGEXP_LIKE(p_value, '^[0-9]{4}[-/][0-9]{2}[-/][0-9]{2}') THEN
            RETURN 'DATE';
        ELSE
            RETURN 'TEXT';
        END IF;
      END;

      FUNCTION parse_date(p_value VARCHAR2) RETURN TIMESTAMP IS
        v_date TIMESTAMP;
      BEGIN
        BEGIN
            -- حالت‌های متداول تاریخ ورودی
            IF REGEXP_LIKE(p_value, '^\d{4}-\d{2}-\d{2}$') THEN
                v_date := TO_TIMESTAMP(p_value, 'YYYY-MM-DD');
            ELSIF REGEXP_LIKE(p_value, '^\d{4}/\d{2}/\d{2}$') THEN
                v_date := TO_TIMESTAMP(p_value, 'YYYY/MM/DD');
            ELSIF REGEXP_LIKE(p_value, '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$') THEN
                v_date := TO_TIMESTAMP(p_value, 'YYYY-MM-DD HH24:MI');
            ELSIF REGEXP_LIKE(p_value, '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$') THEN
                v_date := TO_TIMESTAMP(p_value, 'YYYY-MM-DD HH24:MI:SS');
            ELSE
                v_date := NULL;
            END IF;
        EXCEPTION WHEN OTHERS THEN
            v_date := NULL;
        END;
        RETURN v_date;
      END;
   BEGIN
       FOR I IN 1 .. p_parm.COUNT LOOP
           v_input := p_parm(I);
           v_pat := '\{' || (i-1) || '(:([^}]+))?\}';
           v_fmt := REGEXP_SUBSTR(v_result, v_pat, 1, 1, NULL, 2);

           CASE detect_type(v_input)
               WHEN 'NUMBER' THEN
                   v_val := CASE
                       WHEN v_fmt IS NOT NULL THEN TO_CHAR(TO_NUMBER(v_input), v_fmt)
                       ELSE v_input
                   END;

               WHEN 'DATE' THEN
                   DECLARE v_d TIMESTAMP; BEGIN
                       v_d := parse_date(v_input);
                       IF v_d IS NOT NULL THEN
                           v_val := CASE
                               WHEN v_fmt IS NOT NULL THEN TO_CHAR(v_d, v_fmt)
                               ELSE TO_CHAR(v_d, 'YYYY-MM-DD HH24:MI:SS')
                           END;
                       ELSE
                           v_val := v_input; -- فرمت ناشناخته، همون رشته رو برگردون
                       END IF;
                   END;

               WHEN 'NULL' THEN
                   v_val := '';

               ELSE
                   v_val := v_input;
           END CASE;

           v_result := REGEXP_REPLACE(v_result, v_pat, v_val, 1, 0, 'i');
       END LOOP;

       RETURN v_result;
   END;
   
   FUNCTION STR_ECRP_U(p_inpt VARCHAR2, p_key RAW) 
   RETURN RAW
   IS 
   BEGIN
      RETURN 
         DBMS_CRYPTO.ENCRYPT(
            src => UTL_RAW.CAST_TO_RAW(p_inpt),
            typ => DBMS_CRYPTO.ENCRYPT_AES256
                  + DBMS_CRYPTO.CHAIN_CBC
                  + DBMS_CRYPTO.PAD_PKCS5,
            KEY => p_key
         );
   END;
   
   FUNCTION STR_DCRP_U(p_inpt RAW, p_key RAW) 
   RETURN VARCHAR2
   IS 
   BEGIN
      RETURN UTL_RAW.CAST_TO_VARCHAR2(
         DBMS_CRYPTO.DECRYPT(
            src => p_inpt,
            typ => DBMS_CRYPTO.ENCRYPT_AES256
                  + DBMS_CRYPTO.CHAIN_CBC
                  + DBMS_CRYPTO.PAD_PKCS5,
            KEY => p_key
           )
       );
   END;
   
   FUNCTION CNV_CTOB_U(p_clob CLOB)
   RETURN BLOB
   AS
    v_blob   BLOB;
    v_dest_offset INTEGER := 1;
    v_src_offset  INTEGER := 1;
    v_lang_ctx    INTEGER := 0;
    v_warning     INTEGER := 0;
   BEGIN
       -- ایجاد BLOB خالی
       DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);

       -- تبدیل Base64 درون CLOB به BLOB واقعی
       DBMS_LOB.CONVERTTOBLOB(
           dest_lob     => v_blob,
           src_clob     => p_clob,
           amount       => DBMS_LOB.LOBMAXSIZE,
           dest_offset  => v_dest_offset,
           src_offset   => v_src_offset,
           blob_csid    => DBMS_LOB.DEFAULT_CSID,
           lang_context => v_lang_ctx,
           warning      => v_warning
       );

       RETURN v_blob;
   END;
   
END PBLC_COMN_PKG;

/
