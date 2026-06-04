--------------------------------------------------------
--  DDL for Package Body DML_ADYM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_ADYM_PKG" AS
/******************************************************************************
   NAME:       DML_ADYM_PKG
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
      
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.REF_CODE := l_in.GET_STRING('REF_CODE');
      --l_row.CODE := SYS_GUID;
      l_row.DOMN_NAME := l_in.GET_STRING('DOMN_NAME');
      l_row.DOMN_CMNT := l_in.GET_STRING('DOMN_CMNT');
      l_row.RWNO := l_in.GET_NUMBER('RWNO');
      l_row.NAME := l_in.GET_STRING('NAME');
      l_row.DOMN_DESC := l_in.GET_STRING('DOMN_DESC');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      
      INSERT INTO APP_DYNAMIC_DOMAIN(/*CODE,*/ REF_CODE, DOMN_NAME, DOMN_CMNT, RWNO, NAME, DOMN_DESC, REGN_LANG)
      VALUES (/*l_row.CODE,*/ l_row.REF_CODE, l_row.DOMN_NAME, l_row.DOMN_CMNT, l_row.RWNO, l_row.NAME, l_row.DOMN_DESC, l_row.REGN_LANG);
      
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
      
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.REF_CODE := l_in.GET_STRING('REF_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.DOMN_NAME := l_in.GET_STRING('DOMN_NAME');
      l_row.DOMN_CMNT := l_in.GET_STRING('DOMN_CMNT');
      l_row.RWNO := l_in.GET_NUMBER('RWNO');
      l_row.NAME := l_in.GET_STRING('NAME');
      l_row.DOMN_DESC := l_in.GET_STRING('DOMN_DESC');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      
      UPDATE APP_DYNAMIC_DOMAIN
         SET (NAME, RWNO, DOMN_DESC, REGN_LANG) = (SELECT l_row.NAME, l_row.RWNO, l_row.DOMN_DESC, l_row.REGN_LANG FROM dual)
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
      
      l_row APP_DYNAMIC_DOMAIN%ROWTYPE; 
   BEGIN      
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE APP_DYNAMIC_DOMAIN
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

END DML_ADYM_PKG;

/
