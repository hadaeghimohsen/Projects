--------------------------------------------------------
--  DDL for Package Body DML_NEWS_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_NEWS_PKG" AS
/******************************************************************************
   NAME:       DML_NEWS_PKG
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
      
      l_row NEWS%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := SYS_GUID;
      l_row.NEWS_NAME := l_in.GET_STRING('NEWS_NAME');
      l_row.NEWS_DESC := l_in.GET_STRING('NEWS_DESC');
      l_row.URL := l_in.GET_STRING('URL');
      --l_row.STAT := l_in.GET_STRING('STAT');
      l_row.SHOW_DATE := l_in.GET_DATE('SHOW_DATE');
      l_row.EXPR_DATE := l_in.GET_DATE('EXPR_DATE');
      
      INSERT INTO NEWS(/*CODE,*/ NEWS_NAME, NEWS_DESC, URL, /*STAT,*/ SHOW_DATE, EXPR_DATE)
      VALUES (/*l_row.CODE,*/ l_row.NEWS_NAME, l_row.NEWS_DESC, l_row.URL, /*l_row.STAT,*/ l_row.SHOW_DATE, l_row.EXPR_DATE);
      
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
      
      l_row NEWS%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.NEWS_NAME := l_in.GET_STRING('NEWS_NAME');
      l_row.NEWS_DESC := l_in.GET_STRING('NEWS_DESC');
      l_row.URL := l_in.GET_STRING('URL');
      l_row.STAT := l_in.GET_STRING('STAT');
      l_row.SHOW_DATE := l_in.GET_DATE('SHOW_DATE');
      l_row.EXPR_DATE := l_in.GET_DATE('EXPR_DATE');
      
      UPDATE NEWS
         SET (NEWS_NAME, NEWS_DESC, URL, STAT, SHOW_DATE, EXPR_DATE) = (SELECT l_row.NEWS_NAME, l_row.NEWS_DESC, l_row.URL, l_row.STAT, l_row.SHOW_DATE, l_row.EXPR_DATE FROM dual)
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
      
      l_row NEWS%ROWTYPE; 
   BEGIN      
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE NEWS
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

END DML_NEWS_PKG;

/
