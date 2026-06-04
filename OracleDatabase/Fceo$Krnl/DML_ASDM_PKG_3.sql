--------------------------------------------------------
--  DDL for Package Body DML_ASDM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_ASDM_PKG" AS
/******************************************************************************
   NAME:       DML_ASDM_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/29/2025      hadaeghi       1. Created this package body.
******************************************************************************/

   FUNCTION INS_OPRT_U(p_in clob) 
   RETURN clob      
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.get_time;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row APP_STATIC_DOMAIN%rowtype; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.NAME := l_in.GET_STRING('NAME');
      l_row.RWNO := l_in.GET_NUMBER('RWNO');
      l_row.VALU := l_in.GET_STRING('VALU');
      l_row.DOMN_DESC := l_in.GET_STRING('DOMN_DESC');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      
      INSERT INTO APP_STATIC_DOMAIN(CODE, NAME, RWNO, VALU, DOMN_DESC, REGN_LANG)
      VALUES (l_row.CODE, l_row.NAME, l_row.RWNO, l_row.VALU, l_row.DOMN_DESC, l_row.REGN_LANG);
      
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.get_time - l_strt)               
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

   FUNCTION UPD_OPRT_U(p_in clob) 
   RETURN clob
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.get_time;
      
      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row APP_STATIC_DOMAIN%rowtype; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.NAME := l_in.GET_STRING('NAME');
      l_row.RWNO := l_in.GET_NUMBER('RWNO');
      l_row.VALU := l_in.GET_STRING('VALU');
      l_row.DOMN_DESC := l_in.GET_STRING('DOMN_DESC');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      
      UPDATE APP_STATIC_DOMAIN
         SET (NAME, RWNO, DOMN_DESC) = (select l_row.NAME, l_row.RWNO, l_row.DOMN_DESC from dual)
       WHERE CODE = l_row.CODE
         AND VALU = l_row.VALU
         AND REGN_LANG = l_row.REGN_LANG;
      
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.get_time - l_strt)               
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

   FUNCTION DEL_OPRT_U(p_in clob) 
   RETURN clob
      IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.get_time;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row APP_STATIC_DOMAIN%rowtype; 
   BEGIN      
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.VALU := l_in.GET_STRING('VALU');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      
      DELETE APP_STATIC_DOMAIN
       WHERE CODE = l_row.CODE
         AND VALU = l_row.VALU
         AND REGN_LANG = l_row.REGN_LANG;
      
      -- Serialize برگردوندن به CLOB      
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.get_time - l_strt)               
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

END DML_ASDM_PKG;

/
