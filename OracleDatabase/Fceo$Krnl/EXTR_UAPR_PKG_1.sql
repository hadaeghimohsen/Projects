--------------------------------------------------------
--  DDL for Package Body EXTR_UAPR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_UAPR_PKG" AS
/******************************************************************************
   NAME:       EXTR_UAPR_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION_PRIVILEGE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for USER_APPLICATION_PRIVILEGE
******************************************************************************/

   FUNCTION INIT_UAPR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION_PRIVILEGE%ROWTYPE; 
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
   
   FUNCTION GRNT_UAPR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION_PRIVILEGE%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {USRA_CODE: "", PRVL_CODE: "", STAT: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 36, "PRVL_DESC": "GRANT UAPR"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_UAPR_PKG.MRG_OPRT_U(p_in));
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
   
   FUNCTION RVOK_UAPR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION_PRIVILEGE%ROWTYPE; 
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {CODE: "", STAT: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := JSON_OBJECT_T.parse(EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 37, "PRVL_DESC": "REVOKE UAPR"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_UAPR_PKG.UPD_OPRT_U(p_in));
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
   
   FUNCTION CHCK_UAPR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION_PRIVILEGE%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
      l_prvlRwno PRIVILEGE.RWNO%TYPE;
      l_prvlSysRwno SYSTEM_APPLICATION.RWNO%TYPE;
      l_contRows NUMBER;
   BEGIN
      -- Parse ورودی      
      -- Sample data input : {USRA_CODE: "", PRVL_RWNO: "", SYS_CODE: ""}
            
      -- get column data from json
      l_row.USRA_CODE := JSON_VALUE(p_in, '$.USRA_CODE');
      l_prvlRwno := JSON_VALUE(p_in, '$.PRVL_RWNO');
      l_prvlSysRwno := JSON_VALUE(p_in, '$.SYS_RWNO');
      
      -- IF EXISTS ROW for accesse privilege for user to role granted
      SELECT COUNT(a.CODE)
        INTO l_contRows
        FROM USER_APPLICATION_PRIVILEGE A,
             PRIVILEGE b,
             USER_APPLICATION C,
             SYSTEM_APPLICATION d
       WHERE a.PRVL_CODE = b.CODE
         AND a.USRA_CODE = c.CODE
         AND a.USRA_CODE = l_row.USRA_CODE         
         AND b.RWNO = l_prvlRwno
         AND b.SYS_CODE = d.CODE 
         AND d.RWNO = l_prvlSysRwno         
         AND a.STAT = '002'
         AND c.STAT = '002';
      
      -- Does the intended user have the requested access? 
      IF l_contRows = 0 THEN RAISE l_excp; END IF;
      
      -- Serialize برگردوندن به CLOB
      RETURN 
         JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
         );
   EXCEPTION
      WHEN OTHERS THEN
      BEGIN
         l_sqlcode  := SQLCODE;
         l_sqlerrm   := SQLERRM;
         l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         
         RETURN 
            JSON_OBJECT(
               'rspncode' VALUE '-1',
               'rspndesc' VALUE 'failed',
               'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
               'sqlerrm' VALUE l_sqlerrm,
               'sqlcode' VALUE l_sqlcode,
               'sqlbacktrac' VALUE l_backtrac
            );
      END;
   END;
   
   FUNCTION COPY_UAPR_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION_PRIVILEGE%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {USRA_CODE: "", REF_USRA_CODE: ""}
      
      -- get column data from json
      l_row.USRA_CODE := l_in.GET_STRING('REF_USRA_CODE');
         
      -- IF EXISTS ROW for accesse privilege for user to role granted
      FOR P IN (
          SELECT b.CODE
            FROM USER_APPLICATION A,
                 USER_APPLICATION_PRIVILEGE b
           WHERE b.USRA_CODE = A.CODE             
             AND a.CODE = l_row.USRA_CODE
             AND a.STAT = '002'
             AND b.STAT = '002'
      )
      LOOP
         l_tjson.PUT('USRA_CODE', l_in.GET_STRING('USRA_CODE'));
         l_tjson.PUT('PRVL_CODE', p.CODE);
         l_tjson.PUT('STAT', '002');
         -- 1. In the first step, we want to check that we have access to execute this procedure.
         l_tjson := JSON_OBJECT_T.parse(EXTR_UAPR_PKG.GRNT_UAPR_U(l_in.TO_CLOB()));

         -- IF NOT ACCESS TO PRIVILEGE
         IF(l_tjson.GET_NUMBER('rspncode') = 0) THEN RAISE l_excp; END IF;
      END LOOP;
      
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
   

   FUNCTION LIST_UAPR_U(p_in CLOB) RETURN CLOB IS
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
         SELECT COUNT(*) INTO l_total_count FROM USER_APPLICATION_PRIVILEGE T
         WHERE T.STAT IS NOT NULL
           AND 1=1;
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'USRA_CODE' VALUE RAWTOHEX(T.USRA_CODE),
                  'PRVL_CODE' VALUE RAWTOHEX(T.PRVL_CODE),
                  'STAT' VALUE T.STAT,
                  'STAT_DESC' VALUE SD.DOMN_DESC,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE T.CRET_BY
               )
               ORDER BY CASE WHEN T.STAT = '002' THEN 0 ELSE 1 END, T.CRET_DATE DESC RETURNING CLOB
            ) INTO l_data
            FROM USER_APPLICATION_PRIVILEGE T
            LEFT JOIN D$ACTV SD ON T.STAT = SD.VALU
            WHERE T.STAT IS NOT NULL
           AND 1=1
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
END EXTR_UAPR_PKG;

/
