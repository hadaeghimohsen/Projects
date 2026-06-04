--------------------------------------------------------
--  DDL for Package Body INTR_SYSD_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."INTR_SYSD_PKG" AS
/******************************************************************************
   NAME:       EXTR_USRA_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION SAVE_SYSD_U(p_in CLOB) 
   RETURN CLOB
      IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      
      l_row SYSTEM_AUDIT%ROWTYPE;
      l_tjson JSON_OBJECT_T;
      l_excp EXCEPTION;       
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      -- Sample data input : {USRA_CODE: "", LOG_TYPE: "", LOG_DESC: ""}
      
      -- get column data from json
      -- WE CAN DO YOUR JOB
      l_tjson := JSON_OBJECT_T.parse(DML_SYSD_PKG.INS_OPRT_U(p_in));
      -- CHECK JOB RUN SUCCESSFULLY?
      IF(l_tjson.GET_NUMBER('rspncode') != 0) THEN RAISE l_excp; END IF;
      
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
         SELECT 
           JSON_OBJECT(
               'rspncode' VALUE '-1',
               'rspndesc' VALUE 'failed',
               'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;

END INTR_SYSD_PKG;

/
