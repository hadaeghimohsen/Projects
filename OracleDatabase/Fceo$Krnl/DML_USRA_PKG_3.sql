--------------------------------------------------------
--  DDL for Package Body DML_USRA_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_USRA_PKG" AS
/******************************************************************************
   NAME:       DML_USRA_PKG
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
      
      l_row USER_APPLICATION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json      
      --- USER_APPLICATION ---
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.USER_APP_NAME := l_in.GET_STRING('USER_APP_NAME');
      l_row.USER_APP_DESC := l_in.GET_STRING('USER_APP_DESC');
      l_row.PASS_WORD := l_in.GET_STRING('PASS_WORD');
      l_row.SALT_KEY := l_in.GET_STRING('SALT_KEY');
      l_row.PIN_CODE := l_in.GET_STRING('PIN_CODE');
      l_row.SMS_CODE := l_in.GET_STRING('SMS_CODE');
      l_row.QR_LINK_DEV_CODE := l_in.GET_STRING('QR_LINK_DEV_CODE');
      l_row.STIC_2FA_CODE := l_in.GET_STRING('STIC_2FA_CODE');
      l_row.DYNC_2FA_CODE := l_in.GET_STRING('DYNC_2FA_CODE');
      l_row.TOTP_SCRT_KEY := l_in.GET_STRING('TOTP_SCRT_KEY');
      l_row.TOTP_STAT := l_in.GET_STRING('TOTP_STAT');
      l_row.LAST_USE_TIME := l_in.GET_DATE('LAST_USE_TIME');
      l_row.LAST_TOTP_STEP := l_in.GET_NUMBER('LAST_TOTP_STEP');
      l_row.FRST_LOGN_STAT := l_in.GET_STRING('FRST_LOGN_STAT');
      l_row.MUST_CHNG_PASS := l_in.GET_STRING('MUST_CHNG_PASS');
      l_row.LAST_UPDT_PASS := l_in.GET_DATE('LAST_UPDT_PASS');
      l_row.STAT := l_in.GET_STRING('STAT');
      l_row.CMNT := l_in.GET_STRING('CMNT');
      l_row.PHON_NUMB := l_in.GET_STRING('PHON_NUMB');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      l_row.EMAL_ADRS := l_in.GET_STRING('EMAL_ADRS');
      l_row.EMAL_VERF_STAT := l_in.GET_STRING('EMAL_VERF_STAT');
      l_row.FALD_LGIN_CONT := l_in.GET_NUMBER('FALD_LGIN_CONT');
      l_row.LOCK_END_TIME := l_in.GET_DATE('LOCK_END_TIME');
      
      INSERT INTO USER_APPLICATION (CODE,USER_APP_NAME,USER_APP_DESC,PASS_WORD,SALT_KEY,PIN_CODE,SMS_CODE,QR_LINK_DEV_CODE,STIC_2FA_CODE,DYNC_2FA_CODE,TOTP_SCRT_KEY,TOTP_STAT,LAST_USE_TIME,LAST_TOTP_STEP,FRST_LOGN_STAT,MUST_CHNG_PASS,LAST_UPDT_PASS,STAT,CMNT,PHON_NUMB,REGN_LANG,EMAL_ADRS,EMAL_VERF_STAT,FALD_LGIN_CONT,LOCK_END_TIME) 
      VALUES (l_row.CODE,l_row.USER_APP_NAME,l_row.USER_APP_DESC,l_row.PASS_WORD,l_row.SALT_KEY,l_row.PIN_CODE,l_row.SMS_CODE,l_row.QR_LINK_DEV_CODE,l_row.STIC_2FA_CODE,l_row.DYNC_2FA_CODE,l_row.TOTP_SCRT_KEY,l_row.TOTP_STAT,l_row.LAST_USE_TIME,l_row.LAST_TOTP_STEP,l_row.FRST_LOGN_STAT,l_row.MUST_CHNG_PASS,l_row.LAST_UPDT_PASS,l_row.STAT,l_row.CMNT,l_row.PHON_NUMB,l_row.REGN_LANG,l_row.EMAL_ADRS,l_row.EMAL_VERF_STAT,l_row.FALD_LGIN_CONT,l_row.LOCK_END_TIME);
      
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
      
      l_row USER_APPLICATION%ROWTYPE; 
   BEGIN
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --- USER_APPLICATION ---
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.USER_APP_NAME := l_in.GET_STRING('USER_APP_NAME');
      l_row.USER_APP_DESC := l_in.GET_STRING('USER_APP_DESC');
      l_row.PASS_WORD := l_in.GET_STRING('PASS_WORD');
      l_row.SALT_KEY := l_in.GET_STRING('SALT_KEY');
      l_row.PIN_CODE := l_in.GET_STRING('PIN_CODE');
      l_row.SMS_CODE := l_in.GET_STRING('SMS_CODE');
      l_row.QR_LINK_DEV_CODE := l_in.GET_STRING('QR_LINK_DEV_CODE');
      l_row.STIC_2FA_CODE := l_in.GET_STRING('STIC_2FA_CODE');
      l_row.DYNC_2FA_CODE := l_in.GET_STRING('DYNC_2FA_CODE');
      l_row.TOTP_SCRT_KEY := l_in.GET_STRING('TOTP_SCRT_KEY');
      l_row.TOTP_STAT := l_in.GET_STRING('TOTP_STAT');
      l_row.LAST_USE_TIME := l_in.GET_DATE('LAST_USE_TIME');
      l_row.LAST_TOTP_STEP := l_in.GET_NUMBER('LAST_TOTP_STEP');
      l_row.FRST_LOGN_STAT := l_in.GET_STRING('FRST_LOGN_STAT');
      l_row.MUST_CHNG_PASS := l_in.GET_STRING('MUST_CHNG_PASS');
      l_row.LAST_UPDT_PASS := l_in.GET_DATE('LAST_UPDT_PASS');
      l_row.STAT := l_in.GET_STRING('STAT');
      l_row.CMNT := l_in.GET_STRING('CMNT');
      l_row.PHON_NUMB := l_in.GET_STRING('PHON_NUMB');
      l_row.REGN_LANG := l_in.GET_STRING('REGN_LANG');
      l_row.EMAL_ADRS := l_in.GET_STRING('EMAL_ADRS');
      l_row.EMAL_VERF_STAT := l_in.GET_STRING('EMAL_VERF_STAT');
      l_row.FALD_LGIN_CONT := l_in.GET_NUMBER('FALD_LGIN_CONT');
      l_row.LOCK_END_TIME := l_in.GET_DATE('LOCK_END_TIME');
      
      UPDATE USER_APPLICATION
         SET
             CODE = l_row.CODE,
             USER_APP_NAME = l_row.USER_APP_NAME,
             USER_APP_DESC = l_row.USER_APP_DESC,
             PASS_WORD = l_row.PASS_WORD,
             SALT_KEY = l_row.SALT_KEY,
             PIN_CODE = l_row.PIN_CODE,
             SMS_CODE = l_row.SMS_CODE,
             QR_LINK_DEV_CODE = l_row.QR_LINK_DEV_CODE,
             STIC_2FA_CODE = l_row.STIC_2FA_CODE,
             DYNC_2FA_CODE = l_row.DYNC_2FA_CODE,
             TOTP_SCRT_KEY = l_row.TOTP_SCRT_KEY,
             TOTP_STAT = l_row.TOTP_STAT,
             LAST_USE_TIME = l_row.LAST_USE_TIME,
             LAST_TOTP_STEP = l_row.LAST_TOTP_STEP,
             FRST_LOGN_STAT = l_row.FRST_LOGN_STAT,
             MUST_CHNG_PASS = l_row.MUST_CHNG_PASS,
             LAST_UPDT_PASS = l_row.LAST_UPDT_PASS,
             STAT = l_row.STAT,
             CMNT = l_row.CMNT,
             PHON_NUMB = l_row.PHON_NUMB,
             REGN_LANG = l_row.REGN_LANG,
             EMAL_ADRS = l_row.EMAL_ADRS,
             EMAL_VERF_STAT = l_row.EMAL_VERF_STAT,
             FALD_LGIN_CONT = l_row.FALD_LGIN_CONT,
             LOCK_END_TIME = l_row.LOCK_END_TIME
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
      
      l_row USER_APPLICATION%ROWTYPE; 
   BEGIN      
      -- Parse ورودي
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      --l_row.CODE := l_in.GET_STRING('CODE');
      
      DELETE FROM USER_APPLICATION
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

END DML_USRA_PKG;

/
