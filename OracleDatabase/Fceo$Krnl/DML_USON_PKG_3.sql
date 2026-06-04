--------------------------------------------------------
--  DDL for Package Body DML_USON_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_USON_PKG" AS
/******************************************************************************
   NAME:       DML_USON_PKG
   PURPOSE:    INSERT, UPDATE, DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/29/2025      hadaeghi       1. Created this package body.
******************************************************************************/

   FUNCTION INS_OPRT_U(p_in CLOB) 
   RETURN CLOB      
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row USER_HOST_SESSION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- USER_HOST_SESSION ---
      l_row.HINF_CODE := l_in.GET_STRING('HINF_CODE');
      l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.APP_SNID := l_in.GET_STRING('APP_SNID');
      l_row.LOG_IN_DATE := l_in.GET_DATE('LOG_IN_DATE');
      l_row.LOG_OUT_DATE := l_in.GET_DATE('LOG_OUT_DATE');
      l_row.LOG_SEEN_DATE := l_in.GET_DATE('LOG_SEEN_DATE');
      l_row.ACTV_STAT := l_in.GET_STRING('ACTV_STAT');
      
      INSERT INTO USER_HOST_SESSION (HINF_CODE,USRA_CODE,CODE,APP_SNID,LOG_IN_DATE,LOG_OUT_DATE,LOG_SEEN_DATE,ACTV_STAT) 
      VALUES (l_row.HINF_CODE,l_row.USRA_CODE,l_row.CODE,l_row.APP_SNID,l_row.LOG_IN_DATE,l_row.LOG_OUT_DATE,l_row.LOG_SEEN_DATE,l_row.ACTV_STAT);
      
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

   FUNCTION UPD_OPRT_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      
      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row USER_HOST_SESSION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- USER_HOST_SESSION ---
      l_row.HINF_CODE := l_in.GET_STRING('HINF_CODE');
      l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.APP_SNID := l_in.GET_STRING('APP_SNID');
      l_row.LOG_IN_DATE := l_in.GET_DATE('LOG_IN_DATE');
      l_row.LOG_OUT_DATE := l_in.GET_DATE('LOG_OUT_DATE');
      l_row.LOG_SEEN_DATE := l_in.GET_DATE('LOG_SEEN_DATE');
      l_row.ACTV_STAT := l_in.GET_STRING('ACTV_STAT');
      
      UPDATE USER_HOST_SESSION
         SET
             HINF_CODE = l_row.HINF_CODE,
             USRA_CODE = l_row.USRA_CODE,
             CODE = l_row.CODE,
             APP_SNID = l_row.APP_SNID,
             LOG_IN_DATE = l_row.LOG_IN_DATE,
             LOG_OUT_DATE = l_row.LOG_OUT_DATE,
             LOG_SEEN_DATE = l_row.LOG_SEEN_DATE,
             ACTV_STAT = l_row.ACTV_STAT
       WHERE CODE = l_row.CODE;      
      
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

   FUNCTION DEL_OPRT_U(p_in CLOB) 
   RETURN CLOB
      IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row USER_HOST_SESSION%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM USER_HOST_SESSION
       WHERE CODE = l_row.CODE;         
      
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

END DML_USON_PKG;

/
