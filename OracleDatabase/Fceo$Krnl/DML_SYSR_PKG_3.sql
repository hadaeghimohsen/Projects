--------------------------------------------------------
--  DDL for Package Body DML_SYSR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_SYSR_PKG" AS
/******************************************************************************
   NAME:       DML_SYSR_PKG
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
      
      l_row SYSTEM_REPORT%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- SYSTEM_REPORT ---
      l_row.SYSR_CODE := l_in.GET_STRING('SYSR_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.SYSR_NAME := l_in.GET_STRING('SYSR_NAME');
      l_row.CMNT := l_in.GET_STRING('CMNT');
      l_row.PATH_ADRS := l_in.GET_STRING('PATH_ADRS');
      l_row.STAT := l_in.GET_STRING('STAT');
      l_row.RPRT_ENGN_TYPE := l_in.GET_STRING('RPRT_ENGN_TYPE');
      
      INSERT INTO SYSTEM_REPORT (SYSR_CODE,CODE,SYSR_NAME,CMNT,PATH_ADRS,STAT,RPRT_ENGN_TYPE) 
      VALUES (l_row.SYSR_CODE,l_row.CODE,l_row.SYSR_NAME,l_row.CMNT,l_row.PATH_ADRS,l_row.STAT,l_row.RPRT_ENGN_TYPE);
      
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
      
      l_row SYSTEM_REPORT%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- SYSTEM_REPORT ---
      l_row.SYSR_CODE := l_in.GET_STRING('SYSR_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.SYSR_NAME := l_in.GET_STRING('SYSR_NAME');
      l_row.CMNT := l_in.GET_STRING('CMNT');
      l_row.PATH_ADRS := l_in.GET_STRING('PATH_ADRS');
      l_row.STAT := l_in.GET_STRING('STAT');
      l_row.RPRT_ENGN_TYPE := l_in.GET_STRING('RPRT_ENGN_TYPE');
      
      UPDATE SYSTEM_REPORT
         SET
             SYSR_CODE = l_row.SYSR_CODE,
             CODE = l_row.CODE,
             SYSR_NAME = l_row.SYSR_NAME,
             CMNT = l_row.CMNT,
             PATH_ADRS = l_row.PATH_ADRS,
             STAT = l_row.STAT,
             RPRT_ENGN_TYPE = l_row.RPRT_ENGN_TYPE
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
      
      l_row SYSTEM_REPORT%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM SYSTEM_REPORT
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

END DML_SYSR_PKG;

/
