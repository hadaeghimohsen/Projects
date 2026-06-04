--------------------------------------------------------
--  DDL for Package Body DML_URTK_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_URTK_PKG" AS
/******************************************************************************
   NAME:       DML_URTK_PKG
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
      
      l_row USER_REFRESH_TOKEN%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- USER_REFRESH_TOKEN ---
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_row.USON_CODE := l_in.GET_STRING('USON_CODE');
      l_row.TOKN_HASH := l_in.GET_STRING('TOKN_HASH');
      l_row.TOKN_FMLY_CODE := l_in.GET_STRING('TOKN_FMLY_CODE');
      l_row.ISSU_DATE := l_in.GET_DATE('ISSU_DATE');
      l_row.EXPR_DATE := l_in.GET_DATE('EXPR_DATE');
      l_row.REVK_DATE := l_in.GET_DATE('REVK_DATE');
      l_row.REVK_RESN_TYPE := l_in.GET_STRING('REVK_RESN_TYPE');
      l_row.REVK_RESN_DESC := l_in.GET_STRING('REVK_RESN_DESC');
      l_row.RPLC_BY_TOKN_CODE := l_in.GET_STRING('RPLC_BY_TOKN_CODE');
      l_row.ACTV_STAT := l_in.GET_STRING('ACTV_STAT');
      
      INSERT INTO USER_REFRESH_TOKEN (CODE,USRA_CODE,USON_CODE,TOKN_HASH,TOKN_FMLY_CODE,ISSU_DATE,EXPR_DATE,REVK_DATE,REVK_RESN_TYPE,REVK_RESN_DESC,RPLC_BY_TOKN_CODE,ACTV_STAT) 
      VALUES (l_row.CODE,l_row.USRA_CODE,l_row.USON_CODE,l_row.TOKN_HASH,l_row.TOKN_FMLY_CODE,l_row.ISSU_DATE,l_row.EXPR_DATE,l_row.REVK_DATE,l_row.REVK_RESN_TYPE,l_row.REVK_RESN_DESC,l_row.RPLC_BY_TOKN_CODE,l_row.ACTV_STAT);
      
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
      
      l_row USER_REFRESH_TOKEN%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- USER_REFRESH_TOKEN ---
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.USRA_CODE := l_in.GET_STRING('USRA_CODE');
      l_row.USON_CODE := l_in.GET_STRING('USON_CODE');
      l_row.TOKN_HASH := l_in.GET_STRING('TOKN_HASH');
      l_row.TOKN_FMLY_CODE := l_in.GET_STRING('TOKN_FMLY_CODE');
      l_row.ISSU_DATE := l_in.GET_DATE('ISSU_DATE');
      l_row.EXPR_DATE := l_in.GET_DATE('EXPR_DATE');
      l_row.REVK_DATE := l_in.GET_DATE('REVK_DATE');
      l_row.REVK_RESN_TYPE := l_in.GET_STRING('REVK_RESN_TYPE');
      l_row.REVK_RESN_DESC := l_in.GET_STRING('REVK_RESN_DESC');
      l_row.RPLC_BY_TOKN_CODE := l_in.GET_STRING('RPLC_BY_TOKN_CODE');
      l_row.ACTV_STAT := l_in.GET_STRING('ACTV_STAT');
      
      UPDATE USER_REFRESH_TOKEN
         SET
             CODE = l_row.CODE,
             USRA_CODE = l_row.USRA_CODE,
             USON_CODE = l_row.USON_CODE,
             TOKN_HASH = l_row.TOKN_HASH,
             TOKN_FMLY_CODE = l_row.TOKN_FMLY_CODE,
             ISSU_DATE = l_row.ISSU_DATE,
             EXPR_DATE = l_row.EXPR_DATE,
             REVK_DATE = l_row.REVK_DATE,
             REVK_RESN_TYPE = l_row.REVK_RESN_TYPE,
             REVK_RESN_DESC = l_row.REVK_RESN_DESC,
             RPLC_BY_TOKN_CODE = l_row.RPLC_BY_TOKN_CODE,
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
      
      l_row USER_REFRESH_TOKEN%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM USER_REFRESH_TOKEN
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

END DML_URTK_PKG;

/
