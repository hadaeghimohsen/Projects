--------------------------------------------------------
--  DDL for Package Body EXTR_ROLE_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_ROLE_PKG" AS
/******************************************************************************
   NAME:       EXTR_ROLE_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table ROLE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for ROLE
******************************************************************************/

   FUNCTION INIT_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      
      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row ROLE%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json

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
   
   FUNCTION CRET_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row ROLE%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {SYS_CODE: "", ROLE_NAME: "", ROLE_DESC: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 28, "PRVL_DESC": "ADD ROLE"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ROLE_PKG.INS_OPRT_U(p_in));
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
   
   FUNCTION REMV_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row ROLE%ROWTYPE; 
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 30, "PRVL_DESC": "DELETE ROLE"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ROLE_PKG.DEL_OPRT_U(p_in));
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
   
   FUNCTION UPDT_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row ROLE%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", ROLE_NAME: "", ROLE_DESC: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 29, "PRVL_DESC": "UPDATE ROLE"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ROLE_PKG.UPD_OPRT_U(p_in));
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
   
   FUNCTION ACTV_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row ROLE%ROWTYPE; 
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", STAT: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 31, "PRVL_DESC": "ACTIVE ROLE"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ROLE_PKG.UPD_OPRT_U(p_in));
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
   
   FUNCTION DACT_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row ROLE%ROWTYPE; 
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", STAT: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 32, "PRVL_DESC": "DEACTIVE ROLE"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ROLE_PKG.UPD_OPRT_U(p_in));
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
   
   FUNCTION DUPL_ROLE_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row ROLE%ROWTYPE;
      lr_role ROLE%ROWTYPE;  
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {REF_ROLE_CODE, SYS_CODE: "", ROLE_NAME: "", ROLE_DESC: ""}
            
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('REF_ROLE_CODE');
      
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 33, "PRVL_DESC": "DUPLICATE ROLE"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_ROLE_PKG.INS_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      -- Get new role data
      SELECT *
        INTO lr_role
        FROM ROLE A
       WHERE a.ROLE_NAME = l_in.GET_STRING('ROLE_NAME')
         AND a.SYS_CODE = l_in.GET_STRING('SYS_CODE');
      
      -- reset json tmp data
      l_tjson := JSON_OBJECT_T();
      
      -- Copy roles to new user
      l_tjson.PUT('REF_ROLE_CODE', l_row.CODE);
      l_tjson.PUT('ROLE_CODE', lr_role.CODE);
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(EXTR_ROLP_PKG.COPY_ROLP_U(l_in.TO_CLOB()));
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


   FUNCTION LIST_ROLE_U(p_in CLOB) RETURN CLOB IS
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
         SELECT COUNT(*) INTO l_total_count FROM ROLE T
         WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.ROLE_NAME' NULL ON ERROR) IS NULL OR T.ROLE_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.ROLE_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.ROLE_DESC' NULL ON ERROR) IS NULL OR T.ROLE_DESC LIKE '%' || JSON_VALUE(p_in, '$.filter.ROLE_DESC' NULL ON ERROR) || '%');
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'ROLE_NAME' VALUE T.ROLE_NAME,
                  'ROLE_DESC' VALUE T.ROLE_DESC,
                  'STAT' VALUE T.STAT,
                  'STAT_DESC' VALUE SD.DOMN_DESC,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE T.CRET_BY
               )
               ORDER BY CASE WHEN T.STAT = '002' THEN 0 ELSE 1 END, T.CRET_DATE DESC RETURNING CLOB
            ) INTO l_data
            FROM ROLE T
            LEFT JOIN D$ACTV SD ON T.STAT = SD.VALU
            WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.ROLE_NAME' NULL ON ERROR) IS NULL OR T.ROLE_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.ROLE_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.ROLE_DESC' NULL ON ERROR) IS NULL OR T.ROLE_DESC LIKE '%' || JSON_VALUE(p_in, '$.filter.ROLE_DESC' NULL ON ERROR) || '%')
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
END EXTR_ROLE_PKG;

/
