--------------------------------------------------------
--  DDL for Package Body EXTR_USRA_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_USRA_PKG" AS
/******************************************************************************
   NAME:       EXTR_USRA_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for USER_APPLICATION
******************************************************************************/

   FUNCTION INIT_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      -- get column data from json
      l_row.USER_APP_NAME := JSON_VALUE(p_in, '$.USER_APP_NAME');
      l_row.EMAL_ADRS := JSON_VALUE(p_in, '$.EMAL_ADRS');
      
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
               'sqlbacktrac' VALUE l_backtrac,
               'input' VALUE p_in
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;
   
   FUNCTION LGIN_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
      l_lginType VARCHAR(3);
   BEGIN
      -- Parse ورودی
     
      -- Sample data input : {lgintype: "", CODE: "", USER_APP_NAME: "", PASS_WORD: "", PIN_CODE: "", STIC_2FA_CODE: "", LAST_TOTP_STEP: ""}      
      
      -- get column data from json
      --l_row.USER_APP_NAME := l_in.GET_STRING('USER_APP_NAME');
      l_lginType := JSON_VALUE(p_in, '$.lgintype');
      l_row.USER_APP_NAME := JSON_VALUE(p_in, '$.USER_APP_NAME');      
      
      SELECT *
        INTO l_row
        FROM USER_APPLICATION A
       WHERE USER_APP_NAME = l_row.USER_APP_NAME 
         AND STAT = '002';
      
      -- IF NOT EXISTS USER APPLICATION WE MUST RAISE EXCEPTION 
      IF SQL%ROWCOUNT != 1 THEN RAISE l_excp; END IF; 
      
      -- Check validation with operation
      IF l_lginType = '001' THEN         
         -- password
         l_row.PASS_WORD := DBMS_CRYPTO.HASH(
                   UTL_I18N.STRING_TO_RAW(JSON_VALUE(p_in, '$.PASS_WORD') || l_row.SALT_KEY, 'AL32UTF8'),
                   3 --DBMS_CRYPTO.HASH_SH256
                );
         
         SELECT *
           INTO l_row
           FROM USER_APPLICATION A
          WHERE a.CODE = l_row.CODE
            AND a.PASS_WORD = l_row.PASS_WORD;
      ELSIF l_lginType = '002' THEN 
         -- pincode
         l_row.PIN_CODE := JSON_VALUE(p_in, '$.PIN_CODE');
         
         SELECT *
           INTO l_row
           FROM USER_APPLICATION A
          WHERE a.CODE = l_row.CODE
            AND a.PIN_CODE = 
                DBMS_CRYPTO.HASH(
                   UTL_I18N.STRING_TO_RAW( l_row.PIN_CODE || l_row.SALT_KEY, 'AL32UTF8'),
                   3 --DBMS_CRYPTO.HASH_SH256
                );
      ELSIF l_lginType = '003' THEN 
         -- static 2FA 
         l_row.PASS_WORD := JSON_VALUE(p_in, '$.PASS_WORD');
         l_row.STIC_2FA_CODE := JSON_VALUE(p_in, '$.STIC_2FA_CODE');
         
         SELECT *
           INTO l_row
           FROM USER_APPLICATION A
          WHERE a.CODE = l_row.CODE
            AND a.PASS_WORD = 
                DBMS_CRYPTO.HASH(
                   UTL_I18N.STRING_TO_RAW(l_row.PASS_WORD || l_row.SALT_KEY, 'AL32UTF8'),
                   3 --DBMS_CRYPTO.HASH_SH256
                )
            AND a.STIC_2FA_CODE = 
                DBMS_CRYPTO.HASH(
                   UTL_I18N.STRING_TO_RAW(l_row.STIC_2FA_CODE || l_row.SALT_KEY, 'AL32UTF8'),
                   3 --DBMS_CRYPTO.HASH_SH256
                );
      ELSE 
         RAISE l_excp;
      END IF;
      
      -- IF NOT EXISTS USER APPLICATION WE MUST RAISE EXCEPTION 
      IF SQL%ROWCOUNT != 1 THEN RAISE l_excp; END IF;
      -- IF ENABLED TOTP WE MUST CHECK TOTP_STEP
      IF l_row.TOTP_STAT = '002' THEN 
         IF NOT (l_row.LAST_TOTP_STEP IS NULL OR l_row.LAST_TOTP_STEP < JSON_VALUE(p_in, '$.LAST_TOTP_STEP')) THEN 
            RAISE l_excp;
         ELSE
            l_row.LAST_TOTP_STEP := JSON_VALUE(p_in, '$.LAST_TOTP_STEP');
            
            UPDATE USER_APPLICATION
               SET LAST_TOTP_STEP = l_row.LAST_TOTP_STEP
                  ,LAST_USE_TIME = SYSTIMESTAMP
             WHERE CODE = l_row.CODE;
         END IF;
      END IF;
      
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := 
         EXTR_USRA_PKG.CHCK_PRIV_U(
            JSON_OBJECT(
               'SYS_RWNO' VALUE 1,
               'PRVL_RWNO' VALUE 41,
               'PRVL_DESC' VALUE 'ACCESS LOGIN USRA', 
               'USRA_CODE' VALUE l_row.CODE                
            )
         );
      
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
     
      -- Save Log document in system evevnts or log operation
      l_tjson := 
         INTR_SYSD_PKG.SAVE_SYSD_U(
            JSON_OBJECT(                  
               'LOG_TYPE' VALUE '009', 
               'LOG_DESC' VALUE 'Login to system',
               'USRA_CODE' VALUE l_row.CODE                
             )
         );
      
      -- SET UserAppName in Oracle context
      APP_CNTX_PKG.SET_CNTX_P('userappname', l_row.USER_APP_NAME);
      APP_CNTX_PKG.SET_CNTX_P('usracode', l_row.CODE);
      
      <<L$EndF>>
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
      
   FUNCTION LGOT_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE; 
      l_tjson CLOB;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      -- Sample data input: {lgottype: "001" USER_APP_NAME: ""}
      
      -- get column data from json
      SELECT *
        INTO l_row
        FROM USER_APPLICATION
       WHERE USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME');
      IF(NVL(l_row.CODE, '') = '') THEN l_row.CODE := APP_CNTX_PKG.GET_CNTX_U('usracode'); END IF;  
      
      -- Save Log document in system evevnts or log operation
      l_tjson := 
         INTR_SYSD_PKG.SAVE_SYSD_U(
            JSON_OBJECT(                  
                  'LOG_TYPE' VALUE '010', 
                  'LOG_DESC' VALUE 'Logout from system',
                  'USRA_CODE' VALUE l_row.CODE                
            )
         );
      
      -- Clear Oracle Context
      APP_CNTX_PKG.CLER_CNTX_P;
      
      <<L$EndF>>
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
      
   FUNCTION CRET_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : 
      -- { USER_APP_NAME: "", USER_APP_DESC: "", CMNT: ""}
      
      -- IF EXISTS USER RETURN
      SELECT *
        INTO l_row
        FROM USER_APPLICATION A
       WHERE a.USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME');
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := 
         EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 38, "PRVL_DESC": "ADD USRA"}');
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.INS_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      <<L$EndF>>      
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
   
   FUNCTION REMV_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : {CODE: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 40, "PRVL_DESC": "DELETE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.DEL_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      <<L$EndF>>
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
      
   FUNCTION UPDT_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "001", oprtdesc: "Update common user data", CODE: "", USER_APP_DESC: "", CMNT: ""}      
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 39, "PRVL_DESC": "UPDATE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.UPD_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      <<L$EndF>>
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
      
   FUNCTION ACTV_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "005", oprtdesc: "Activate user", CODE: "", STAT: "002"}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 42, "PRVL_DESC": "ACTIVE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.UPD_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      <<L$EndF>>
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
      
   FUNCTION DACT_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS      
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "001", oprtdesc: "create new user", CODE: "", STAT: ""}
            
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 43, "PRVL_DESC": "DEACTIVE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.UPD_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      <<L$EndF>>      
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
      
   FUNCTION UPDT_PSWD_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      -- Sample data input : { CODE: "", PASS_WORD: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 39, "PRVL_DESC": "UPDATE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.UPD_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
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
      
   FUNCTION UPDT_PINC_U(p_in CLOB) 
   RETURN CLOB
   IS 
      
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      -- Sample data input : { CODE: "", PIN_CODE: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 39, "PRVL_DESC": "UPDATE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := (DML_USRA_PKG.UPD_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
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
      
   FUNCTION DUPL_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS 
      
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      lr_usra USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "", CODE: "", USER_APP_NAME: "", USER_APP_DESC: "", 
      --   PASS_WORD, "", PIN_CODE: "", STIC_2FA_CODE: "", CMNT: ""}      
      
      -- get column data from json
      l_row.CODE := JSON_VALUE(p_in, '$.CODE');
      
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 44, "PRVL_DESC": "DUPLICATE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      l_tjson := (DML_USRA_PKG.INS_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- Get new user data
      SELECT *
        INTO lr_usra
        FROM USER_APPLICATION A
       WHERE a.USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME');
      
      -- Set CODE in json data
      -- Set password for new user       
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := 
         DML_USRA_PKG.UPD_OPRT_U(
            JSON_OBJECT(
               'oprttype' VALUE '002',
               'CODE' VALUE lr_usra.CODE,
               'USER_APP_NAME' VALUE JSON_VALUE(p_in, '$.USER_APP_NAME')               
            )
         );
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      -- reset json tmp data
     
      -- Copy roles to new user
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := 
         EXTR_UARL_PKG.COPY_UARL_U(
            JSON_OBJECT(
               'REF_USRA_CODE' VALUE l_row.CODE,
               'USRA_CODE' VALUE lr_usra.CODE
            )
         );
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- reset json tmp data
      -- Copy roles to new user
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := 
         EXTR_UAPR_PKG.COPY_UAPR_U(
            JSON_OBJECT(
               'REF_USRA_CODE' VALUE l_row.CODE,
               'USRA_CODE' VALUE lr_usra.CODE
            )
         );
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
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
   
   FUNCTION INST_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      lr_usra USER_APPLICATION%ROWTYPE;
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "", CODE: "", USER_APP_NAME: "", USER_APP_DESC: "", 
      --   PASS_WORD, "", PIN_CODE: "", STIC_2FA_CODE: "", CMNT: ""}      
      
      -- get column data from json
      l_row.CODE := JSON_VALUE(p_in, '$.CODE');
      
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := (EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 61, "PRVL_DESC": "INSTANCE USRA"}'));
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      l_tjson := (DML_USRA_PKG.INS_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- Get new user data
      SELECT *
        INTO lr_usra
        FROM USER_APPLICATION A
       WHERE a.USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME');
      
      -- Set CODE in json data
      -- Set password for new user       
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := 
         DML_USRA_PKG.UPD_OPRT_U(
            JSON_OBJECT(
               'oprttype' VALUE '002',
               'CODE' VALUE lr_usra.CODE,
               'USER_APP_NAME' VALUE JSON_VALUE(p_in, '$.USER_APP_NAME')               
            )
         );
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;      
      
      -- reset json tmp data
     
      -- Copy roles to new user
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := 
         EXTR_UAIN_PKG.COPY_UAIN_U(
            JSON_OBJECT(
               'USRA_CODE' VALUE l_row.CODE,
               'UINS_CODE' VALUE lr_usra.CODE
            )
         );
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
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
      
   FUNCTION CHCK_PRIV_U(p_in CLOB) 
   RETURN CLOB
   IS 
      
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE;
      l_tjson CLOB; 
      l_excp EXCEPTION; 
   BEGIN
      -- Parse ورودی
      -- Sample data input : {USRA_CODE: "", PRVL_RWNO: "", SYS_CODE: ""}
      
      -- get column data from json
      -- At this stage, the level of access required is checked by Roles and specific access levels.
      -- This is done by two functions EXTR_UARL_PKG.CHCK_UARL_U and EXTR_UAPR_PKG.CHCK_UAPR_U.
      l_tjson := EXTR_UARL_PKG.CHCK_UARL_U(p_in);
      -- IF ACCESS TO PRIVILEGE GOTO End Function
      IF(JSON_VALUE(l_tjson, '$.rspncode') = 0) THEN GOTO L$EndF; END IF;      
      
      -- IF ACCESS TO ROLE PRIVILEGE GOTO End Function 
      l_tjson := EXTR_UAPR_PKG.CHCK_UAPR_U(p_in);
      -- IF NOT ACCESS TO ROLE PRIVILEGE Raise Exception  
      -- BUT IF ACCESS TO ROLE PRIVILEGE RETURN SUCCESSFULY
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      <<L$EndF>>
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
   
   FUNCTION ENBL_TOTP_U(p_in CLOB) 
   RETURN CLOB
   IS 
      
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE; 
      l_tjson CLOB;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "007", CODE: "", SCRT_KEY: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 59, "PRVL_DESC": "ENABLE TOTP USRA"}');
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := DML_USRA_PKG.UPD_OPRT_U(p_in);
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
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
      
   FUNCTION DSBL_TOTP_U(p_in CLOB) 
   RETURN CLOB
   IS 
      
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE; 
      l_tjson CLOB;
      l_excp EXCEPTION;      
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "008", CODE: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.
      l_tjson := EXTR_USRA_PKG.CHCK_PRIV_U('{"SYS_CODE": 1, "PRVL_RWNO": 60, "PRVL_DESC": "DISABLE TOTP USRA"}');
      -- IF NOT ACCESS TO PRIVILEGE
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
      -- IF YOU HAVE ACCESS PRIVILEGE WE CAN DO YOUR JOB
      l_tjson := DML_USRA_PKG.UPD_OPRT_U(p_in);
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(JSON_VALUE(l_tjson, '$.rspncode') != 0) THEN RAISE l_excp; END IF;
      
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
   
   FUNCTION GETP_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE; 
      l_tjson CLOB;
      l_excp EXCEPTION;
   BEGIN
      -- Parse ورودی
      -- Sample data input : {oprttype: "009", CODE: ""}
      
      -- get column data from json
      -- 1. In the first step, we want to check that we have access to execute this procedure.

      WITH SESSION_INFO AS (
             SELECT
                 -- اطلاعات نسخه Oracle
                 (SELECT BANNER FROM V$VERSION WHERE ROWNUM = 1) AS DATABASE_VERSION,
                 
                 -- اطلاعات پایگاه داده
                 SYS_CONTEXT('USERENV', 'DB_NAME') AS DATABASE_NAME,
                 SYS_CONTEXT('USERENV', 'DB_UNIQUE_NAME') AS UNIQUE_DB_NAME,
                 SYS_CONTEXT('USERENV', 'CON_NAME') AS CONTAINER_NAME,
                 SYS_CONTEXT('USERENV', 'CON_ID') AS CONTAINER_ID,
                 
                 -- زمان سرور
                 TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS SERVER_TIME,
                 TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF3') AS SERVER_TIMESTAMP,
                 
                 -- اطلاعات نشست فعلی
                 SYS_CONTEXT('USERENV', 'SESSION_USER') AS SESSION_USER,
                 SYS_CONTEXT('USERENV', 'SESSIONID') AS SESSION_ID,
                 SYS_CONTEXT('USERENV', 'OS_USER') AS OS_USER,
                 SYS_CONTEXT('USERENV', 'HOST') AS CLIENT_HOSTNAME,
                 SYS_CONTEXT('USERENV', 'IP_ADDRESS') AS CLIENT_IP_ADDRESS,
                 SYS_CONTEXT('USERENV', 'TERMINAL') AS TERMINAL,
                 SYS_CONTEXT('USERENV', 'MODULE') AS APPLICATION_MODULE,
                 SYS_CONTEXT('USERENV', 'ACTION') AS APPLICATION_ACTION,
                 SYS_CONTEXT('USERENV', 'CLIENT_INFO') AS CLIENT_INFO,
                 SYS_CONTEXT('USERENV', 'CLIENT_PROGRAM_NAME') AS CLIENT_PROGRAM_NAME,
                 
                 -- اطلاعات شبکه و احراز هویت
                 SYS_CONTEXT('USERENV', 'NETWORK_PROTOCOL') AS NETWORK_PROTOCOL,
                 SYS_CONTEXT('USERENV', 'AUTHENTICATION_METHOD') AS AUTH_METHOD,
                 SYS_CONTEXT('USERENV', 'IDENTIFICATION_TYPE') AS IDENTIFICATION_TYPE,
                 SYS_CONTEXT('USERENV', 'ISDBA') AS IS_DBA,
                 
                 -- اطلاعات اضافی
                 SYS_CONTEXT('USERENV', 'LANGUAGE') AS SESSION_LANGUAGE,
                 SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA
                 
             FROM DUAL
         )
         SELECT 
             JSON_OBJECT(
                 -- ورودی درخواست
                 'INPUT_USERNAME' VALUE JSON_VALUE(p_in, '$.USER_APP_NAME'),
                 
                 -- اطلاعات اتصال دیتابیس
                 'CONNECTION_INFO' VALUE JSON_OBJECT(
                     'DATABASE_VERSION' VALUE SI.DATABASE_VERSION,
                     'DATABASE_NAME' VALUE SI.DATABASE_NAME,
                     'UNIQUE_DB_NAME' VALUE SI.UNIQUE_DB_NAME,
                     'CONTAINER_NAME' VALUE SI.CONTAINER_NAME,
                     'SERVER_TIME' VALUE SI.SERVER_TIME,
                     'SERVER_TIMESTAMP' VALUE SI.SERVER_TIMESTAMP,
                     'SESSION_ID' VALUE SI.SESSION_ID,
                     'SESSION_USER' VALUE SI.SESSION_USER,
                     'CLIENT_IP' VALUE NVL(SI.CLIENT_IP_ADDRESS, 'N/A'),
                     'CLIENT_HOST' VALUE NVL(SI.CLIENT_HOSTNAME, 'N/A'),
                     'CLIENT_PROGRAM' VALUE NVL(SI.CLIENT_PROGRAM_NAME, 'N/A'),
                     'OS_USER' VALUE NVL(SI.OS_USER, 'N/A'),
                     'TERMINAL' VALUE NVL(SI.TERMINAL, 'N/A'),
                     'NETWORK_PROTOCOL' VALUE NVL(SI.NETWORK_PROTOCOL, 'N/A'),
                     'AUTH_METHOD' VALUE NVL(SI.AUTH_METHOD, 'N/A'),
                     'IS_DBA' VALUE SI.IS_DBA,
                     'LANGUAGE' VALUE SI.SESSION_LANGUAGE,
                     'APPLICATION_MODULE' VALUE NVL(SI.APPLICATION_MODULE, 'N/A')
                 ) FORMAT JSON,
                 
                 -- اطلاعات کاربر از جدول USER_APPLICATION
                 'USER_INFO' VALUE (
                     SELECT JSON_OBJECT(
                         'CODE' VALUE RAWTOHEX(U.CODE),
                         'USER_APP_NAME' VALUE U.USER_APP_NAME,
                         'USER_APP_DESC' VALUE U.USER_APP_DESC,
                         'STAT' VALUE U.STAT,
                         'CMNT' VALUE U.CMNT,
                         'PHON_NUMB' VALUE U.PHON_NUMB,
                         'EMAL_ADRS' VALUE U.EMAL_ADRS,
                         'EMAL_VERF_STAT' VALUE U.EMAL_VERF_STAT,
                         'REGN_LANG' VALUE U.REGN_LANG,
                         'TOTP_STAT' VALUE U.TOTP_STAT,
                         'FRST_LOGN_STAT' VALUE U.FRST_LOGN_STAT,
                         'MUST_CHNG_PASS' VALUE U.MUST_CHNG_PASS,
                         'FALD_LGIN_CONT' VALUE U.FALD_LGIN_CONT,
                         'LAST_USE_TIME' VALUE TO_CHAR(U.LAST_USE_TIME, 'YYYY-MM-DD HH24:MI:SS'),
                         'LAST_UPDT_PASS' VALUE TO_CHAR(U.LAST_UPDT_PASS, 'YYYY-MM-DD'),
                         'LOCK_END_TIME' VALUE TO_CHAR(U.LOCK_END_TIME, 'YYYY-MM-DD HH24:MI:SS'),
                         'CRET_BY' VALUE U.CRET_BY,
                         'CRET_DATE' VALUE TO_CHAR(U.CRET_DATE, 'YYYY-MM-DD HH24:MI:SS'),
                         'MDFY_BY' VALUE U.MDFY_BY,
                         'MDFY_DATE' VALUE TO_CHAR(U.MDFY_DATE, 'YYYY-MM-DD HH24:MI:SS')
                     )
                     FROM FCEO$KRNL.USER_APPLICATION U
                     WHERE U.USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME')
                 ) FORMAT JSON,
                 
                 -- بررسی تطابق کاربر نشست با کاربر جستجو شده
                 'SESSION_MATCH' VALUE CASE 
                     WHEN EXISTS (
                         SELECT 1 FROM FCEO$KRNL.USER_APPLICATION U 
                         WHERE U.USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME') 
                         AND U.USER_APP_NAME = SI.SESSION_USER
                     ) THEN 'YES' 
                     ELSE 'NO' 
                 END,
                 
                 -- اطلاعات امنیتی
                 'SECURITY_INFO' VALUE JSON_OBJECT(
                     'HAS_PASSWORD' VALUE CASE WHEN U2.PASS_WORD IS NOT NULL THEN 'YES' ELSE 'NO' END,
                     'HAS_SALT_KEY' VALUE CASE WHEN U2.SALT_KEY IS NOT NULL THEN 'YES' ELSE 'NO' END,
                     'HAS_PIN_CODE' VALUE CASE WHEN U2.PIN_CODE IS NOT NULL THEN 'YES' ELSE 'NO' END,
                     'TWO_FA_ENABLED' VALUE CASE 
                         WHEN U2.TOTP_STAT = 'YES' OR U2.STIC_2FA_CODE IS NOT NULL 
                         THEN 'YES' ELSE 'NO' 
                     END,
                     'ACCOUNT_LOCKED' VALUE CASE 
                         WHEN U2.LOCK_END_TIME > SYSTIMESTAMP THEN 'YES' 
                         ELSE 'NO' 
                     END,
                     'NEED_PASSWORD_CHANGE' VALUE NVL(U2.MUST_CHNG_PASS, 'NO')
                 ) FORMAT JSON
                 
             ) INTO l_tjson
             
         FROM SESSION_INFO SI
         LEFT JOIN FCEO$KRNL.USER_APPLICATION U2 ON U2.USER_APP_NAME = JSON_VALUE(p_in, '$.USER_APP_NAME');
     
      -- CHECK JOB RUN SUCCESSFULLY?
      
      
      -- Serialize برگردوندن به CLOB
      RETURN 
         JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'result' VALUE JSON_QUERY(l_tjson, '$')
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
   
   FUNCTION LIST_USRA_U(p_in CLOB) 
   RETURN CLOB
   IS      
      l_out CLOB;
      l_data CLOB;
      l_user_name USER_APPLICATION.USER_APP_NAME%TYPE;
      l_oper_type VARCHAR2(3);
      l_page_numb NUMBER;
      l_page_size USER_APPLICATION.VIEW_PAGE_SIZE%TYPE;
      l_offset NUMBER;
      l_total_count NUMBER;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
   BEGIN
      l_user_name := APP_CNTX_PKG.GET_CNTX_U('userappname');
      l_oper_type := JSON_VALUE(p_in, '$.operation.type' NULL ON ERROR);
      l_page_numb := TO_NUMBER(JSON_VALUE(p_in, '$.pagenumb' NULL ON ERROR));
      IF l_page_numb IS NULL OR l_page_numb < 1 THEN
         l_page_numb := 1;
      END IF;

      BEGIN
         SELECT NVL(VIEW_PAGE_SIZE, 20) INTO l_page_size
         FROM USER_APPLICATION
         WHERE USER_APP_NAME = l_user_name;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            l_page_size := 20;
      END;

      IF l_oper_type = '001' THEN
         SELECT COUNT(*) INTO l_total_count
         FROM USER_APPLICATION U
         WHERE U.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.USER_APP_NAME' NULL ON ERROR) IS NULL
                OR U.USER_APP_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.USER_APP_NAME' NULL ON ERROR) || '%')
           AND (JSON_VALUE(p_in, '$.filter.PHON_NUMB' NULL ON ERROR) IS NULL
                OR U.PHON_NUMB LIKE '%' || JSON_VALUE(p_in, '$.filter.PHON_NUMB' NULL ON ERROR) || '%')
           AND (JSON_VALUE(p_in, '$.filter.EMAL_ADRS' NULL ON ERROR) IS NULL
                OR U.EMAL_ADRS LIKE '%' || JSON_VALUE(p_in, '$.filter.EMAL_ADRS' NULL ON ERROR) || '%');

         l_offset := (l_page_numb - 1) * l_page_size;

         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(U.CODE),
                  'USER_APP_NAME' VALUE U.USER_APP_NAME,
                  'USER_APP_DESC' VALUE U.USER_APP_DESC,
                  'STAT' VALUE U.STAT,
                  'STAT_DESC' VALUE ST.DOMN_DESC,
                  'PHON_NUMB' VALUE U.PHON_NUMB,
                  'EMAL_ADRS' VALUE U.EMAL_ADRS,
                  'FRST_LOGN_STAT' VALUE U.FRST_LOGN_STAT,
                  'FRST_LOGN_STAT_DESC' VALUE FL.DOMN_DESC,
                  'MUST_CHNG_PASS' VALUE U.MUST_CHNG_PASS,
                  'MUST_CHNG_PASS_DESC' VALUE MP.DOMN_DESC,
                  'TOTP_STAT' VALUE U.TOTP_STAT,
                  'TOTP_STAT_DESC' VALUE TS.DOMN_DESC,
                  'EMAL_VERF_STAT' VALUE U.EMAL_VERF_STAT,
                  'EMAL_VERF_STAT_DESC' VALUE EV.DOMN_DESC,
                  'REGN_LANG' VALUE U.REGN_LANG,
                  'REGN_LANG_DESC' VALUE RL.DOMN_DESC,
                  'FALD_LGIN_CONT' VALUE U.FALD_LGIN_CONT,
                  'LOCK_END_TIME' VALUE TO_CHAR(U.LOCK_END_TIME, 'YYYY-MM-DD HH24:MI:SS'),
                  'LAST_USE_TIME' VALUE TO_CHAR(U.LAST_USE_TIME, 'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE U.CRET_BY,
                  'CRET_DATE' VALUE TO_CHAR(U.CRET_DATE, 'YYYY-MM-DD HH24:MI:SS'),
                  'MDFY_BY' VALUE U.MDFY_BY,
                  'MDFY_DATE' VALUE TO_CHAR(U.MDFY_DATE, 'YYYY-MM-DD HH24:MI:SS')
               )
               ORDER BY CASE WHEN U.STAT = '002' THEN 0 ELSE 1 END, U.CRET_DATE DESC
               RETURNING CLOB
            ) INTO l_data
            FROM USER_APPLICATION U
            LEFT JOIN D$ACTV ST ON U.STAT = ST.VALU
            LEFT JOIN D$YSNO FL ON U.FRST_LOGN_STAT = FL.VALU
            LEFT JOIN D$YSNO MP ON U.MUST_CHNG_PASS = MP.VALU
            LEFT JOIN D$ACTV TS ON U.TOTP_STAT = TS.VALU
            LEFT JOIN D$YSNO EV ON U.EMAL_VERF_STAT = EV.VALU
            LEFT JOIN D$RGLN RL ON U.REGN_LANG = RL.VALU
            WHERE U.STAT IS NOT NULL
              AND (JSON_VALUE(p_in, '$.filter.USER_APP_NAME' NULL ON ERROR) IS NULL
                   OR U.USER_APP_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.USER_APP_NAME' NULL ON ERROR) || '%')
              AND (JSON_VALUE(p_in, '$.filter.PHON_NUMB' NULL ON ERROR) IS NULL
                   OR U.PHON_NUMB LIKE '%' || JSON_VALUE(p_in, '$.filter.PHON_NUMB' NULL ON ERROR) || '%')
              AND (JSON_VALUE(p_in, '$.filter.EMAL_ADRS' NULL ON ERROR) IS NULL
                   OR U.EMAL_ADRS LIKE '%' || JSON_VALUE(p_in, '$.filter.EMAL_ADRS' NULL ON ERROR) || '%')
            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               l_data := '[]';
         END;

         IF l_data IS NULL THEN
            l_data := '[]';
         END IF;

         l_out := JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'page_numb' VALUE l_page_numb,
            'page_size' VALUE l_page_size,
            'total_count' VALUE l_total_count,
            'data' VALUE JSON_QUERY(l_data, '$')
         );
      ELSE
         l_out := JSON_OBJECT(
            'rspncode' VALUE '-1',
            'rspndesc' VALUE 'invalid operation type: ' || l_oper_type
         );
      END IF;

      RETURN l_out;
   EXCEPTION
      WHEN OTHERS THEN
         l_sqlcode  := SQLCODE;
         l_sqlerrm   := SQLERRM;
         l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         RETURN JSON_OBJECT(
            'rspncode' VALUE '-1',
            'rspndesc' VALUE 'failed',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'sqlerrm' VALUE l_sqlerrm,
            'sqlcode' VALUE l_sqlcode,
            'sqlbacktrac' VALUE l_backtrac,
            'input' VALUE p_in
         );
   END;

END EXTR_USRA_PKG;

/
