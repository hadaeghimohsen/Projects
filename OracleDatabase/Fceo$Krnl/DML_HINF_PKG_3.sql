--------------------------------------------------------
--  DDL for Package Body DML_HINF_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_HINF_PKG" AS
/******************************************************************************
   NAME:       DML_HINF_PKG
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
      
      l_row HOST_INFORMATION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- HOST_INFORMATION ---
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.DEV_NAME := l_in.GET_STRING('DEV_NAME');
      l_row.PLAT_FORM_TYPE := l_in.GET_STRING('PLAT_FORM_TYPE');
      l_row.PLAT_FORM := l_in.GET_STRING('PLAT_FORM');
      l_row.OS_TYPE := l_in.GET_STRING('OS_TYPE');
      l_row.OS_VERS := l_in.GET_STRING('OS_VERS');
      l_row.IP_ADRS := l_in.GET_STRING('IP_ADRS');
      l_row.AGNT_DESC := l_in.GET_STRING('AGNT_DESC');
      l_row.APP_VER := l_in.GET_STRING('APP_VER');
      l_row.MAC_ADRS := l_in.GET_STRING('MAC_ADRS');
      l_row.ACTV_STAT := l_in.GET_STRING('ACTV_STAT');
      l_row.LAST_LGIN_DNRM := l_in.GET_DATE('LAST_LGIN_DNRM');
      
      INSERT INTO HOST_INFORMATION (CODE,DEV_NAME,PLAT_FORM_TYPE,PLAT_FORM,OS_TYPE,OS_VERS,IP_ADRS,AGNT_DESC,APP_VER,MAC_ADRS,ACTV_STAT,LAST_LGIN_DNRM) 
      VALUES (l_row.CODE,l_row.DEV_NAME,l_row.PLAT_FORM_TYPE,l_row.PLAT_FORM,l_row.OS_TYPE,l_row.OS_VERS,l_row.IP_ADRS,l_row.AGNT_DESC,l_row.APP_VER,l_row.MAC_ADRS,l_row.ACTV_STAT,l_row.LAST_LGIN_DNRM);
      
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
      
      l_row HOST_INFORMATION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- HOST_INFORMATION ---
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.DEV_NAME := l_in.GET_STRING('DEV_NAME');
      l_row.PLAT_FORM_TYPE := l_in.GET_STRING('PLAT_FORM_TYPE');
      l_row.PLAT_FORM := l_in.GET_STRING('PLAT_FORM');
      l_row.OS_TYPE := l_in.GET_STRING('OS_TYPE');
      l_row.OS_VERS := l_in.GET_STRING('OS_VERS');
      l_row.IP_ADRS := l_in.GET_STRING('IP_ADRS');
      l_row.AGNT_DESC := l_in.GET_STRING('AGNT_DESC');
      l_row.APP_VER := l_in.GET_STRING('APP_VER');
      l_row.MAC_ADRS := l_in.GET_STRING('MAC_ADRS');
      l_row.ACTV_STAT := l_in.GET_STRING('ACTV_STAT');
      l_row.LAST_LGIN_DNRM := l_in.GET_DATE('LAST_LGIN_DNRM');
      
      UPDATE HOST_INFORMATION
         SET
             CODE = l_row.CODE,
             DEV_NAME = l_row.DEV_NAME,
             PLAT_FORM_TYPE = l_row.PLAT_FORM_TYPE,
             PLAT_FORM = l_row.PLAT_FORM,
             OS_TYPE = l_row.OS_TYPE,
             OS_VERS = l_row.OS_VERS,
             IP_ADRS = l_row.IP_ADRS,
             AGNT_DESC = l_row.AGNT_DESC,
             APP_VER = l_row.APP_VER,
             MAC_ADRS = l_row.MAC_ADRS,
             ACTV_STAT = l_row.ACTV_STAT,
             LAST_LGIN_DNRM = l_row.LAST_LGIN_DNRM
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
      
      l_row HOST_INFORMATION%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM HOST_INFORMATION
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

END DML_HINF_PKG;

/
