--------------------------------------------------------
--  DDL for Package Body EXTR_CSTR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_CSTR_PKG" AS
/******************************************************************************
   NAME:       EXTR_CSTR_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table CONNECTION_STRING.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for CONNECTION_STRING
******************************************************************************/

   FUNCTION INIT_CSTR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row CONNECTION_STRING%ROWTYPE; 
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
   
   FUNCTION CRET_CSTR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row CONNECTION_STRING%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {DSRC_CODE: "", USRA_CODE: "", STAT: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 10, "PRVL_DESC": "ADD CSTR"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_CSTR_PKG.INS_OPRT_U(p_in));
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
   
   FUNCTION REMV_CSTR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row CONNECTION_STRING%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 11, "PRVL_DESC": "DELETE CSTR"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_CSTR_PKG.DEL_OPRT_U(p_in));
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
   
   FUNCTION ACTV_CSTR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row CONNECTION_STRING%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", STAT:""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 12, "PRVL_DESC": "ACTIVE CSTR"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_CSTR_PKG.UPD_OPRT_U(p_in));
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
   
   FUNCTION DACT_CSTR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row CONNECTION_STRING%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", STAT:""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 13, "PRVL_DESC": "DEACTIVE CSTR"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_CSTR_PKG.UPD_OPRT_U(p_in));
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
   
   FUNCTION GET_CSTR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row CONNECTION_STRING%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
      l_userappname USER_APPLICATION.USER_APP_NAME%TYPE;
      l_syscode raw(16);
      l_rootname VARCHAR2(30);     
      l_cstr CONNECTION_STRING.CNCT_STRN_DNRM%TYPE;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {USRA_CODE: "1", USER_APP_NAME: "", ROOT_NAME: "KERNEL", SYS_CODE: ""}
      
      -- get column data from json
      --l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_userappname := l_in.GET_STRING('USER_APP_NAME');
      l_syscode := l_in.GET_STRING('SYS_CODE');
      l_rootname := l_in.GET_STRING('ROOT_NAME');
      
      IF l_syscode is not null THEN
         SELECT PBLC_COMN_PKG.STR_FRMT_U(
                  A.CNCT_STRN_DNRM,
                  SYS.ODCIVARCHAR2LIST( PBLC_COMN_PKG.STR_DCRP_U(a.PASS_WORD, A.SALT_KEY))
                )
           INTO l_cstr
           FROM V#USRA_CSTR_DSRC A
          WHERE A.USER_APP_NAME = upper(l_userappname)
            AND a.SYS_CODE = l_syscode;
      ELSIF NVL(l_rootname, '') != '' THEN 
         SELECT PBLC_COMN_PKG.STR_FRMT_U(
                  A.CNCT_STRN_DNRM,
                  SYS.ODCIVARCHAR2LIST( PBLC_COMN_PKG.STR_DCRP_U(a.PASS_WORD, A.SALT_KEY))
                )
           INTO l_cstr
           FROM V#USRA_CSTR_DSRC A
          WHERE A.USER_APP_NAME = upper(l_userappname)
            and a.ROOT_NAME = l_rootname;
      ELSE 
         RAISE l_excp;
      END IF;       
      
      if nvl(l_cstr, '') = '' then raise l_excp; end if; 
      
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'sclrvalu' VALUE L_cstr,
            'jsonvalu' value ''
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
     

   FUNCTION LIST_CSTR_U(p_in CLOB) RETURN CLOB IS
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
         SELECT COUNT(*) INTO l_total_count FROM CONNECTION_STRING T
         WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.CNCT_STRN_DNRM' NULL ON ERROR) IS NULL OR T.CNCT_STRN_DNRM LIKE '%' || JSON_VALUE(p_in, '$.filter.CNCT_STRN_DNRM' NULL ON ERROR) || '%');
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'DSRC_CODE' VALUE RAWTOHEX(T.DSRC_CODE),
                  'USRA_CODE' VALUE RAWTOHEX(T.USRA_CODE),
                  'CNCT_STRN_DNRM' VALUE T.CNCT_STRN_DNRM,
                  'STAT' VALUE T.STAT,
                  'STAT_DESC' VALUE SD.DOMN_DESC,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE T.CRET_BY
               )
               ORDER BY CASE WHEN T.STAT = '002' THEN 0 ELSE 1 END, T.CRET_DATE DESC RETURNING CLOB
            ) INTO l_data
            FROM CONNECTION_STRING T
            LEFT JOIN D$ACTV SD ON T.STAT = SD.VALU
            WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.CNCT_STRN_DNRM' NULL ON ERROR) IS NULL OR T.CNCT_STRN_DNRM LIKE '%' || JSON_VALUE(p_in, '$.filter.CNCT_STRN_DNRM' NULL ON ERROR) || '%')
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
END EXTR_CSTR_PKG;

/
