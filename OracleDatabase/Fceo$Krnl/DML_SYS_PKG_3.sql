--------------------------------------------------------
--  DDL for Package Body DML_SYS_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_SYS_PKG" AS
/******************************************************************************
   NAME:       DML_HSON_PKG
   PURPOSE:

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
      
      l_row SYSTEM_APPLICATION%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.SYS_NAME := l_in.GET_STRING('SYS_NAME');
      l_row.SYS_DESC := l_in.GET_STRING('SYS_DESC');      

      INSERT INTO SYSTEM_APPLICATION(SYS_NAME, SYS_DESC)
      VALUES (l_row.SYS_NAME, l_row.SYS_DESC);
      
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
           )           INTO l_out
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
      
      l_row SYSTEM_APPLICATION%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.SYS_NAME := l_in.GET_STRING('SYS_NAME');
      l_row.SYS_DESC := l_in.GET_STRING('SYS_DESC');      
      
      UPDATE SYSTEM_APPLICATION
         SET (SYS_NAME, SYS_DESC) = (SELECT l_row.SYS_NAME, l_row.SYS_DESC FROM dual)
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
      
      l_row SYSTEM_APPLICATION%ROWTYPE; 
   BEGIN      
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE SYSTEM_APPLICATION
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
           )           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;

END DML_SYS_PKG;

/
