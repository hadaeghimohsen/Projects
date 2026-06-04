--------------------------------------------------------
--  DDL for Package Body INTR_ASDM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."INTR_ASDM_PKG" AS
/******************************************************************************
   NAME:       EXTR_ASDM_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION INIT_ASDM_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      
      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
      
      l_row APP_STATIC_DOMAIN%ROWTYPE;
      l_stmt VARCHAR2(200);
      l_rowcont NUMBER; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      FOR d_row IN (SELECT DISTINCT CODE FROM APP_STATIC_DOMAIN WHERE REGN_LANG = '054')
      LOOP
         SELECT 'D$' || SUBSTR(d_row.CODE, 3)
           INTO l_stmt
           FROM dual;
         
         SELECT COUNT(View_NAME)
           INTO l_rowcont  
           FROM USER_VIEWS 
          WHERE VIEW_NAME = l_stmt;
          
         IF l_rowcont = 1 THEN 
            EXECUTE IMMEDIATE 'DROP VIEW ' || l_stmt;
         END IF;
         
         EXECUTE IMMEDIATE 'CREATE VIEW ' || l_stmt || ' AS SELECT RWNO, VALU, DOMN_DESC FROM APP_STATIC_DOMAIN sd WHERE sd.REGN_LANG = ''054'' AND CODE = ''' || d_row.CODE || '''';         
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

END INTR_ASDM_PKG;

/
