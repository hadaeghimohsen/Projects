--------------------------------------------------------
--  DDL for Package Body DML_UAIN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_UAIN_PKG" AS
/******************************************************************************
   NAME:       DML_UAIN_PKG
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
      
      l_row USER_APPLICATION_INSTANCE%ROWTYPE; 
   BEGIN
      -- Parse æÑæÏí
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- USER_APPLICATION_INSTANCE ---
      l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_row.UINS_CODE := l_in.GET_STRING('UINS_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.STAT := l_in.GET_STRING('STAT');
      
      INSERT INTO USER_APPLICATION_INSTANCE (USRA_CODE,UINS_CODE,CODE,STAT) 
      VALUES (l_row.USRA_CODE,l_row.UINS_CODE,l_row.CODE,l_row.STAT);
      
      -- Serialize ÈÑÑÏæäÏä Èå CLOB
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
      
      l_row USER_APPLICATION_INSTANCE%ROWTYPE; 
   BEGIN
      -- Parse æÑæÏí
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- USER_APPLICATION_INSTANCE ---
      l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_row.UINS_CODE := l_in.GET_STRING('UINS_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.STAT := l_in.GET_STRING('STAT');
      
      UPDATE USER_APPLICATION_INSTANCE
         SET
             USRA_CODE = l_row.USRA_CODE,
             UINS_CODE = l_row.UINS_CODE,
             CODE = l_row.CODE,
             STAT = l_row.STAT
       WHERE CODE = l_row.CODE;      
      
      -- Serialize ÈÑÑÏæäÏä Èå CLOB
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
      
      l_row USER_APPLICATION_INSTANCE%ROWTYPE; 
   BEGIN      
      -- Parse æÑæÏí
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM USER_APPLICATION_INSTANCE
       WHERE CODE = l_row.CODE;         
      
      -- Serialize ÈÑÑÏæäÏä Èå CLOB      
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

END DML_UAIN_PKG;

/
