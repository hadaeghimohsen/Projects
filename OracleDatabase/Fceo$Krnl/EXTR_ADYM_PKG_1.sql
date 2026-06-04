--------------------------------------------------------
--  DDL for Package Body EXTR_ADYM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_ADYM_PKG" AS
/******************************************************************************
   NAME:       EXTR_ADYM_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table APP_DYNAMIC_DOMAIN.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for APP_DYNAMIC_DOMAIN
******************************************************************************/

   FUNCTION INIT_ADYM_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      
      -- The goals and tasks of this function are as follows:
      -- 1. Checking the access required to execute a procedure.
      
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
        )
        INTO l_out
        FROM DUAL;
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
        
   FUNCTION CRET_ADYM_U(p_in CLOB) 
   RETURN CLOB
      IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {REF_CODE: "", DOMN_NAME: "", DOMN_CMNT: "", RWNO: 0, DOMN_DESC: "", REGN_LANG: ""}      
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 1, "PRVL_DESC": "ADD ADYM"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ADYM_PKG.INS_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      <<L$EndF>>
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
        )
        INTO l_out
        FROM DUAL;
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


   FUNCTION REMV_ADYM_U(p_in CLOB) 
   RETURN CLOB
      IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 3, "PRVL_DESC": "DELETE ADYM"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ADYM_PKG.DEL_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      <<L$EndF>>
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
        )
        INTO l_out
        FROM DUAL;
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

   FUNCTION UPDT_ADYM_U(p_in CLOB) 
   RETURN CLOB
      IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", REF_CODE: "", DOMN_NAME: "", DOMN_CMNT: "", RWNO: 0, DOMN_DESC: "", REGN_LANG: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 2, "PRVL_DESC": "UPDATE ADYM"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ADYM_PKG.UPD_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      <<L$EndF>>
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
        )
        INTO l_out
        FROM DUAL;
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
   

   FUNCTION LIST_ADYM_U(p_in CLOB) RETURN CLOB IS
      l_out CLOB; l_data CLOB;
      l_user_name USER_APPLICATION.USER_APP_NAME%TYPE;
      l_oper_type VARCHAR2(3);
      l_page_numb NUMBER; l_page_size USER_APPLICATION.VIEW_PAGE_SIZE%TYPE;
      l_offset NUMBER; l_total_count NUMBER;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      l_sqlcode NUMBER; l_sqlerrm VARCHAR2(4000); l_backtrac VARCHAR2(4000);
   BEGIN
      l_user_name := APP_CNTX_PKG.GET_CNTX_U('userappname');
      l_oper_type := JSON_VALUE(p_in, '$.operation.type' NULL ON ERROR);
      l_page_numb := TO_NUMBER(JSON_VALUE(p_in, '$.pagenumb' NULL ON ERROR));
      IF l_page_numb IS NULL OR l_page_numb < 1 THEN l_page_numb := 1; END IF;
      BEGIN SELECT NVL(VIEW_PAGE_SIZE, 20) INTO l_page_size FROM USER_APPLICATION WHERE USER_APP_NAME = l_user_name;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_page_size := 20; END;
      IF l_oper_type = '001' THEN
         SELECT COUNT(*) INTO l_total_count FROM APP_DYNAMIC_DOMAIN T
         WHERE (JSON_VALUE(p_in, '$.filter.DOMN_NAME' NULL ON ERROR) IS NULL OR T.DOMN_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.DOMN_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.NAME' NULL ON ERROR) IS NULL OR T.NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.DOMN_DESC' NULL ON ERROR) IS NULL OR T.DOMN_DESC LIKE '%' || JSON_VALUE(p_in, '$.filter.DOMN_DESC' NULL ON ERROR) || '%');
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'DOMN_NAME' VALUE T.DOMN_NAME,
                  'DOMN_CMNT' VALUE T.DOMN_CMNT,
                  'RWNO' VALUE T.RWNO,
                  'NAME' VALUE T.NAME,
                  'DOMN_DESC' VALUE T.DOMN_DESC,
                  'REGN_LANG' VALUE T.REGN_LANG,
                  'REGN_LANG_DESC' VALUE RD.DOMN_DESC,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE T.CRET_BY
               )
               ORDER BY T.DOMN_NAME, T.RWNO RETURNING CLOB
            ) INTO l_data
            FROM APP_DYNAMIC_DOMAIN T
            LEFT JOIN D$RGLN RD ON T.REGN_LANG = RD.VALU
            WHERE (JSON_VALUE(p_in, '$.filter.DOMN_NAME' NULL ON ERROR) IS NULL OR T.DOMN_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.DOMN_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.NAME' NULL ON ERROR) IS NULL OR T.NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.DOMN_DESC' NULL ON ERROR) IS NULL OR T.DOMN_DESC LIKE '%' || JSON_VALUE(p_in, '$.filter.DOMN_DESC' NULL ON ERROR) || '%')
            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_data := '[]'; END;
         IF l_data IS NULL THEN l_data := '[]'; END IF;
         l_out := JSON_OBJECT('rspncode' VALUE '0','rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'page_numb' VALUE l_page_numb,'page_size' VALUE l_page_size,
            'total_count' VALUE l_total_count,
            'data' VALUE JSON_QUERY(l_data, '$'));
      ELSE l_out := JSON_OBJECT('rspncode' VALUE '-1','rspndesc' VALUE 'invalid operation type: ' || l_oper_type); END IF;
      RETURN l_out;
   EXCEPTION WHEN OTHERS THEN
      l_sqlcode := SQLCODE; l_sqlerrm := SQLERRM;
      l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      RETURN JSON_OBJECT('rspncode' VALUE '-1','rspndesc' VALUE 'failed',
         'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
         'sqlerrm' VALUE l_sqlerrm,'sqlcode' VALUE l_sqlcode,
         'sqlbacktrac' VALUE l_backtrac,'input' VALUE p_in);
   END;
END EXTR_ADYM_PKG;

/
