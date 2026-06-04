--------------------------------------------------------
--  DDL for Package Body DML_PTRN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_PTRN_PKG" AS
/******************************************************************************
   NAME:       DML_PTRN_PKG
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
      
      l_row PAYMENT_TRANSACTION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- PAYMENT_TRANSACTION ---
      l_row.PGAT_CODE := l_in.GET_STRING('PGAT_CODE');
      l_row.SYS_CODE := l_in.GET_STRING('SYS_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.RQST_RQID := l_in.GET_STRING('RQST_RQID');
      l_row.RQTP_CODE := l_in.GET_STRING('RQTP_CODE');
      l_row.RWNO := l_in.GET_NUMBER('RWNO');
      l_row.TRAN_DATE := l_in.GET_DATE('TRAN_DATE');
      l_row.AMNT := l_in.GET_NUMBER('AMNT');
      l_row.PAY_STAT := l_in.GET_STRING('PAY_STAT');
      l_row.ISSU_DATE := l_in.GET_DATE('ISSU_DATE');
      l_row.RESP_CODE := l_in.GET_STRING('RESP_CODE');
      l_row.RESP_DESC := l_in.GET_STRING('RESP_DESC');
      l_row.TERM_NO := l_in.GET_STRING('TERM_NO');
      l_row.TRAN_NO := l_in.GET_STRING('TRAN_NO');
      l_row.CARD_NO := l_in.GET_STRING('CARD_NO');
      l_row.FLOW_NO := l_in.GET_STRING('FLOW_NO');
      l_row.REF_NO := l_in.GET_STRING('REF_NO');
      l_row.SERL_NO := l_in.GET_STRING('SERL_NO');
      
      INSERT INTO PAYMENT_TRANSACTION (PGAT_CODE,SYS_CODE,CODE,RQST_RQID,RQTP_CODE,RWNO,TRAN_DATE,AMNT,PAY_STAT,ISSU_DATE,RESP_CODE,RESP_DESC,TERM_NO,TRAN_NO,CARD_NO,FLOW_NO,REF_NO,SERL_NO) 
      VALUES (l_row.PGAT_CODE,l_row.SYS_CODE,l_row.CODE,l_row.RQST_RQID,l_row.RQTP_CODE,l_row.RWNO,l_row.TRAN_DATE,l_row.AMNT,l_row.PAY_STAT,l_row.ISSU_DATE,l_row.RESP_CODE,l_row.RESP_DESC,l_row.TERM_NO,l_row.TRAN_NO,l_row.CARD_NO,l_row.FLOW_NO,l_row.REF_NO,l_row.SERL_NO);
      
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
      
      l_row PAYMENT_TRANSACTION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- PAYMENT_TRANSACTION ---
      l_row.PGAT_CODE := l_in.GET_STRING('PGAT_CODE');
      l_row.SYS_CODE := l_in.GET_STRING('SYS_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.RQST_RQID := l_in.GET_STRING('RQST_RQID');
      l_row.RQTP_CODE := l_in.GET_STRING('RQTP_CODE');
      l_row.RWNO := l_in.GET_NUMBER('RWNO');
      l_row.TRAN_DATE := l_in.GET_DATE('TRAN_DATE');
      l_row.AMNT := l_in.GET_NUMBER('AMNT');
      l_row.PAY_STAT := l_in.GET_STRING('PAY_STAT');
      l_row.ISSU_DATE := l_in.GET_DATE('ISSU_DATE');
      l_row.RESP_CODE := l_in.GET_STRING('RESP_CODE');
      l_row.RESP_DESC := l_in.GET_STRING('RESP_DESC');
      l_row.TERM_NO := l_in.GET_STRING('TERM_NO');
      l_row.TRAN_NO := l_in.GET_STRING('TRAN_NO');
      l_row.CARD_NO := l_in.GET_STRING('CARD_NO');
      l_row.FLOW_NO := l_in.GET_STRING('FLOW_NO');
      l_row.REF_NO := l_in.GET_STRING('REF_NO');
      l_row.SERL_NO := l_in.GET_STRING('SERL_NO');
      
      UPDATE PAYMENT_TRANSACTION
         SET
             PGAT_CODE = l_row.PGAT_CODE,
             SYS_CODE = l_row.SYS_CODE,
             CODE = l_row.CODE,
             RQST_RQID = l_row.RQST_RQID,
             RQTP_CODE = l_row.RQTP_CODE,
             RWNO = l_row.RWNO,
             TRAN_DATE = l_row.TRAN_DATE,
             AMNT = l_row.AMNT,
             PAY_STAT = l_row.PAY_STAT,
             ISSU_DATE = l_row.ISSU_DATE,
             RESP_CODE = l_row.RESP_CODE,
             RESP_DESC = l_row.RESP_DESC,
             TERM_NO = l_row.TERM_NO,
             TRAN_NO = l_row.TRAN_NO,
             CARD_NO = l_row.CARD_NO,
             FLOW_NO = l_row.FLOW_NO,
             REF_NO = l_row.REF_NO,
             SERL_NO = l_row.SERL_NO
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
      
      l_row PAYMENT_TRANSACTION%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM PAYMENT_TRANSACTION
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

END DML_PTRN_PKG;

/
