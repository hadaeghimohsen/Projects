--------------------------------------------------------
--  DDL for Package Body DML_PGAT_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_PGAT_PKG" AS
/******************************************************************************
   NAME:       DML_PGAT_PKG
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
      
      l_row PAYMENT_GATEWAY%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- PAYMENT_GATEWAY ---
      l_row.HINF_CODE := l_in.GET_STRING('HINF_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.PGAT_NAME := l_in.GET_STRING('PGAT_NAME');
      l_row.PGAT_TYPE := l_in.GET_STRING('PGAT_TYPE');
      l_row.PSP_TYPE := l_in.GET_STRING('PSP_TYPE');
      l_row.PGAT_DESC := l_in.GET_STRING('PGAT_DESC');
      l_row.PGAT_DFLT := l_in.GET_STRING('PGAT_DFLT');
      l_row.PGAT_CNCT_TYPE := l_in.GET_STRING('PGAT_CNCT_TYPE');
      l_row.IP_ADRS := l_in.GET_STRING('IP_ADRS');
      l_row.COMM_PORT := l_in.GET_STRING('COMM_PORT');
      l_row.PORT_NUMB := l_in.GET_NUMBER('PORT_NUMB');
      l_row.PRNT_SALE := l_in.GET_STRING('PRNT_SALE');
      l_row.PRNT_CUST := l_in.GET_STRING('PRNT_CUST');
      l_row.AUTO_COMM := l_in.GET_STRING('AUTO_COMM');
      l_row.ACNT_TYPE := l_in.GET_STRING('ACNT_TYPE');
      l_row.BILL_FIND_TYPE := l_in.GET_STRING('BILL_FIND_TYPE');
      l_row.BILL_NO := l_in.GET_STRING('BILL_NO');
      l_row.TERM_NO := l_in.GET_STRING('TERM_NO');
      
      INSERT INTO PAYMENT_GATEWAY (HINF_CODE,CODE,PGAT_NAME,PGAT_TYPE,PSP_TYPE,PGAT_DESC,PGAT_DFLT,PGAT_CNCT_TYPE,IP_ADRS,COMM_PORT,PORT_NUMB,PRNT_SALE,PRNT_CUST,AUTO_COMM,ACNT_TYPE,BILL_FIND_TYPE,BILL_NO,TERM_NO) 
      VALUES (l_row.HINF_CODE,l_row.CODE,l_row.PGAT_NAME,l_row.PGAT_TYPE,l_row.PSP_TYPE,l_row.PGAT_DESC,l_row.PGAT_DFLT,l_row.PGAT_CNCT_TYPE,l_row.IP_ADRS,l_row.COMM_PORT,l_row.PORT_NUMB,l_row.PRNT_SALE,l_row.PRNT_CUST,l_row.AUTO_COMM,l_row.ACNT_TYPE,l_row.BILL_FIND_TYPE,l_row.BILL_NO,l_row.TERM_NO);
      
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
      
      l_row PAYMENT_GATEWAY%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- PAYMENT_GATEWAY ---
      l_row.HINF_CODE := l_in.GET_STRING('HINF_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.PGAT_NAME := l_in.GET_STRING('PGAT_NAME');
      l_row.PGAT_TYPE := l_in.GET_STRING('PGAT_TYPE');
      l_row.PSP_TYPE := l_in.GET_STRING('PSP_TYPE');
      l_row.PGAT_DESC := l_in.GET_STRING('PGAT_DESC');
      l_row.PGAT_DFLT := l_in.GET_STRING('PGAT_DFLT');
      l_row.PGAT_CNCT_TYPE := l_in.GET_STRING('PGAT_CNCT_TYPE');
      l_row.IP_ADRS := l_in.GET_STRING('IP_ADRS');
      l_row.COMM_PORT := l_in.GET_STRING('COMM_PORT');
      l_row.PORT_NUMB := l_in.GET_NUMBER('PORT_NUMB');
      l_row.PRNT_SALE := l_in.GET_STRING('PRNT_SALE');
      l_row.PRNT_CUST := l_in.GET_STRING('PRNT_CUST');
      l_row.AUTO_COMM := l_in.GET_STRING('AUTO_COMM');
      l_row.ACNT_TYPE := l_in.GET_STRING('ACNT_TYPE');
      l_row.BILL_FIND_TYPE := l_in.GET_STRING('BILL_FIND_TYPE');
      l_row.BILL_NO := l_in.GET_STRING('BILL_NO');
      l_row.TERM_NO := l_in.GET_STRING('TERM_NO');
      
      UPDATE PAYMENT_GATEWAY
         SET
             HINF_CODE = l_row.HINF_CODE,
             CODE = l_row.CODE,
             PGAT_NAME = l_row.PGAT_NAME,
             PGAT_TYPE = l_row.PGAT_TYPE,
             PSP_TYPE = l_row.PSP_TYPE,
             PGAT_DESC = l_row.PGAT_DESC,
             PGAT_DFLT = l_row.PGAT_DFLT,
             PGAT_CNCT_TYPE = l_row.PGAT_CNCT_TYPE,
             IP_ADRS = l_row.IP_ADRS,
             COMM_PORT = l_row.COMM_PORT,
             PORT_NUMB = l_row.PORT_NUMB,
             PRNT_SALE = l_row.PRNT_SALE,
             PRNT_CUST = l_row.PRNT_CUST,
             AUTO_COMM = l_row.AUTO_COMM,
             ACNT_TYPE = l_row.ACNT_TYPE,
             BILL_FIND_TYPE = l_row.BILL_FIND_TYPE,
             BILL_NO = l_row.BILL_NO,
             TERM_NO = l_row.TERM_NO
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
      
      l_row PAYMENT_GATEWAY%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM PAYMENT_GATEWAY
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

END DML_PGAT_PKG;

/
