--------------------------------------------------------
--  DDL for Package Body DML_BRDC_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_BRDC_PKG" AS
/******************************************************************************
   NAME:       DML_BRDC_PKG
   PURPOSE:    INSERT, UPDATE,DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for BROADCAST_CONFIG
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
            
      l_row BROADCAST_CONFIG%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json     
      l_row.BRDC_TYPE := l_in.GET_STRING('BRDC_TYPE');
      l_row.BGWK_STAT := l_in.GET_STRING('BGWK_STAT');
      l_row.BGWK_INTR := l_in.GET_NUMBER('BGWK_INTR');
      l_row.WEB_SITE := l_in.GET_STRING('WEB_SITE');
      l_row.LOGN_TYPE := l_in.GET_STRING('LOGN_TYPE');
      l_row.USER_NAME := l_in.GET_STRING('USER_NAME');
      l_row.PASS_WORD := l_in.GET_STRING('PASS_WORD');
      l_row.WEB_SITE_LOGN := l_in.GET_STRING('WEB_SITE_LOGN');
      l_row.WEB_SITE_PSWD := l_in.GET_STRING('WEB_SITE_PSWD');
      l_row.ACES_KEY := l_in.GET_STRING('ACES_KEY');
      l_row.SCRT_KEY := l_in.GET_STRING('SCRT_KEY');
      l_row.TOKN_CODE := l_in.GET_STRING('TOKN_CODE');
      l_row.LINE_NUMB := l_in.GET_STRING('LINE_NUMB');
      l_row.DFLT_STAT := l_in.GET_STRING('DFLT_STAT');
      l_row.FTCH_ROW_NUMB := l_in.GET_NUMBER('FTCH_ROW_NUMB');
      l_row.MIN_STOP_CHRG := l_in.GET_NUMBER('MIN_STOP_CHRG');
      l_row.SERV_TYPE := l_in.GET_STRING('SERV_TYPE');
      l_row.COMP_SNDR := l_in.GET_STRING('COMP_SNDR');
      l_row.SLEP_INTR := l_in.GET_NUMBER('SLEP_INTR');
      l_row.PING_HOST := l_in.GET_STRING('PING_HOST');
      l_row.SEND_STAT := l_in.GET_STRING('SEND_STAT');
      
      INSERT INTO BROADCAST_CONFIG(BRDC_TYPE, BGWK_STAT, BGWK_INTR, WEB_SITE, LOGN_TYPE, USER_NAME, PASS_WORD,
      WEB_SITE_LOGN, WEB_SITE_PSWD, ACES_KEY, SCRT_KEY, TOKN_CODE, LINE_NUMB, DFLT_STAT, FTCH_ROW_NUMB, MIN_STOP_CHRG,
      SERV_TYPE, COMP_SNDR, SLEP_INTR, PING_HOST, SEND_STAT)
      VALUES (l_row.BRDC_TYPE, l_row.BGWK_STAT, l_row.BGWK_INTR, l_row.WEB_SITE, l_row.LOGN_TYPE, l_row.USER_NAME, l_row.PASS_WORD, 
      l_row.WEB_SITE_LOGN, l_row.WEB_SITE_PSWD, l_row.ACES_KEY, l_row.SCRT_KEY, l_row.TOKN_CODE, l_row.LINE_NUMB, l_row.DFLT_STAT, l_row.FTCH_ROW_NUMB, l_row.MIN_STOP_CHRG, 
      l_row.SERV_TYPE, l_row.COMP_SNDR, l_row.SLEP_INTR, l_row.PING_HOST, l_row.SEND_STAT);
      
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
            
      l_row BROADCAST_CONFIG%ROWTYPE;
      l_oprtType VARCHAR2(3); 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json     
      l_oprtType := l_in.GET_STRING('oprttype');
      l_row.CODE := l_in.GET_STRING('CODE');
      l_row.BRDC_TYPE := l_in.GET_STRING('BRDC_TYPE');
      l_row.BGWK_STAT := l_in.GET_STRING('BGWK_STAT');
      l_row.BGWK_INTR := l_in.GET_NUMBER('BGWK_INTR');
      l_row.WEB_SITE := l_in.GET_STRING('WEB_SITE');
      l_row.LOGN_TYPE := l_in.GET_STRING('LOGN_TYPE');
      l_row.USER_NAME := l_in.GET_STRING('USER_NAME');
      l_row.PASS_WORD := l_in.GET_STRING('PASS_WORD');
      l_row.WEB_SITE_LOGN := l_in.GET_STRING('WEB_SITE_LOGN');
      l_row.WEB_SITE_PSWD := l_in.GET_STRING('WEB_SITE_PSWD');
      l_row.ACES_KEY := l_in.GET_STRING('ACES_KEY');
      l_row.SCRT_KEY := l_in.GET_STRING('SCRT_KEY');
      l_row.TOKN_CODE := l_in.GET_STRING('TOKN_CODE');
      l_row.LINE_NUMB := l_in.GET_STRING('LINE_NUMB');
      l_row.DFLT_STAT := l_in.GET_STRING('DFLT_STAT');
      l_row.FTCH_ROW_NUMB := l_in.GET_NUMBER('FTCH_ROW_NUMB');
      l_row.MIN_STOP_CHRG := l_in.GET_NUMBER('MIN_STOP_CHRG');
      l_row.SERV_TYPE := l_in.GET_STRING('SERV_TYPE');
      l_row.COMP_SNDR := l_in.GET_STRING('COMP_SNDR');
      l_row.SLEP_INTR := l_in.GET_NUMBER('SLEP_INTR');
      l_row.PING_HOST := l_in.GET_STRING('PING_HOST');
      l_row.SEND_STAT := l_in.GET_STRING('SEND_STAT');
      
      IF l_oprtType = '001' THEN
         -- Update common data
         UPDATE BROADCAST_CONFIG
            SET (BRDC_TYPE, BGWK_STAT, BGWK_INTR, WEB_SITE, LOGN_TYPE, USER_NAME, PASS_WORD,
                 WEB_SITE_LOGN, WEB_SITE_PSWD, ACES_KEY, SCRT_KEY, TOKN_CODE, LINE_NUMB, DFLT_STAT, FTCH_ROW_NUMB, MIN_STOP_CHRG,
                 SERV_TYPE, COMP_SNDR, SLEP_INTR, PING_HOST) = 
                (SELECT l_row.BRDC_TYPE, l_row.BGWK_STAT, l_row.BGWK_INTR, l_row.WEB_SITE, l_row.LOGN_TYPE, l_row.USER_NAME, l_row.PASS_WORD, 
                        l_row.WEB_SITE_LOGN, l_row.WEB_SITE_PSWD, l_row.ACES_KEY, l_row.SCRT_KEY, l_row.TOKN_CODE, l_row.LINE_NUMB, l_row.DFLT_STAT, l_row.FTCH_ROW_NUMB, l_row.MIN_STOP_CHRG, 
                        l_row.SERV_TYPE, l_row.COMP_SNDR, l_row.SLEP_INTR, l_row.PING_HOST
                   FROM dual)
          WHERE CODE = l_row.CODE; 
      ELSIF l_oprtType = '002' THEN
         -- Activate broadcast config
         UPDATE BROADCAST_CONFIG
            SET SEND_STAT = '002'
          WHERE CODE = l_row.CODE; 
      elsif l_oprtType = '003' then
         -- Deactivate broadcast config
         UPDATE BROADCAST_CONFIG
            SET SEND_STAT = '001'
          WHERE CODE = l_row.CODE;
      end if;
      
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
            
      l_row BROADCAST_CONFIG%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json     
      l_row.CODE := l_in.GET_STRING('CODE');
      
      delete broadcast_config
       where CODE = l_row.CODE;
       
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

END DML_BRDC_PKG;

/
