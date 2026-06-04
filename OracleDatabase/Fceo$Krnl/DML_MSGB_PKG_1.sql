--------------------------------------------------------
--  DDL for Package Body DML_MSGB_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."DML_MSGB_PKG" AS
/******************************************************************************
   NAME:       DML_MSGB_PKG
   PURPOSE:    INSERT, UPDATE,DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for MESSAGE_BOX
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
            
      l_row MESSAGE_BOX%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json     
      l_row.BRDC_CODE := l_in.GET_STRING('BRDC_CODE');
      --l_row.CODE := l_in.GET_STRING('CODE');
      l_row.SYS_CODE := l_in.GET_STRING('SYS_CODE');
      l_row.SEND_DATE := l_in.GET_STRING('SEND_DATE');
      l_row.REF_CODE := l_in.GET_STRING('REF_CODE');
      l_row.PHON_NUMB := l_in.GET_STRING('PHON_NUMB');
      l_row.CHAT_ID := l_in.GET_STRING('CHAT_ID');
      l_row.MESG_TEXT := l_in.GET_STRING('MESG_TEXT');
      l_row.MESG_TYPE := l_in.GET_STRING('MESG_TYPE');
      l_row.STAT := l_in.GET_STRING('STAT');
      --l_row.SERV_MESG_CODE := l_in.GET_STRING('SERV_MESG_CODE');
      --l_row.EROR_CODE := l_in.GET_STRING('EROR_CODE');
      --l_row.EROR_MESG := l_in.GET_STRING('EROR_MESG');
      --l_row.MESG_LENT := l_in.GET_STRING('MESG_LENT');
      l_row.SEND_TYPE := l_in.GET_STRING('SEND_TYPE');
      l_row.BULK_NUMB := l_in.GET_STRING('BULK_NUMB');
      --l_row.PAGE_NUMB_DNRM := l_in.GET_STRING('PAGE_NUMB_DNRM');
      --l_row.VIST_STAT := l_in.GET_STRING('VIST_STAT');
      --l_row.VIST_DATE := l_in.GET_STRING('VIST_DATE');
      
      INSERT INTO MESSAGE_BOX (BRDC_CODE, SYS_CODE, SEND_DATE, REF_CODE, PHON_NUMB, 
      CHAT_ID, MESG_TEXT, MESG_TYPE, STAT, SEND_TYPE, BULK_NUMB)
      VALUES (l_row.BRDC_CODE, l_row.SYS_CODE, l_row.SEND_DATE, l_row.REF_CODE, l_row.PHON_NUMB, 
      l_row.CHAT_ID, l_row.MESG_TEXT, l_row.MESG_TYPE, l_row.STAT, l_row.SEND_TYPE, l_row.BULK_NUMB);
      
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
            
      l_row MESSAGE_BOX%ROWTYPE;
      lr_msgb MESSAGE_BOX%ROWTYPE;
      l_oprtType VARCHAR2(3); 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json     
      l_oprtType := l_in.GET_STRING('oprttype');
      --l_row.BRDC_CODE := l_in.GET_STRING('BRDC_CODE');
      l_row.CODE := l_in.GET_STRING('CODE');
      --l_row.SYS_CODE := l_in.GET_STRING('SYS_CODE');
      l_row.SEND_DATE := l_in.GET_STRING('SEND_DATE');
      l_row.REF_CODE := l_in.GET_STRING('REF_CODE');
      l_row.PHON_NUMB := l_in.GET_STRING('PHON_NUMB');
      l_row.CHAT_ID := l_in.GET_STRING('CHAT_ID');
      l_row.MESG_TEXT := l_in.GET_STRING('MESG_TEXT');
      l_row.MESG_TYPE := l_in.GET_STRING('MESG_TYPE');
      l_row.STAT := l_in.GET_STRING('STAT');
      l_row.SERV_MESG_CODE := l_in.GET_STRING('SERV_MESG_CODE');
      l_row.EROR_CODE := l_in.GET_STRING('EROR_CODE');
      l_row.EROR_MESG := l_in.GET_STRING('EROR_MESG');
      l_row.SEND_TYPE := l_in.GET_STRING('SEND_TYPE');
      l_row.BULK_NUMB := l_in.GET_STRING('BULK_NUMB');
      l_row.VIST_STAT := l_in.GET_STRING('VIST_STAT');
      l_row.VIST_DATE := l_in.GET_STRING('VIST_DATE');
      
      SELECT *
        INTO lr_msgb
        FROM MESSAGE_BOX mb
       WHERE CODE = l_row.CODE;
      
      IF l_oprtType = '001' THEN
         -- Update common data
         UPDATE MESSAGE_BOX
            SET (SEND_DATE, REF_CODE, MESG_TEXT, 
                 MESG_TYPE, SERV_MESG_CODE, EROR_CODE, EROR_MESG, SEND_TYPE, BULK_NUMB) = 
                (SELECT l_row.SEND_DATE, l_row.REF_CODE, l_row.MESG_TEXT, 
                 l_row.MESG_TYPE, l_row.SERV_MESG_CODE, l_row.EROR_CODE, l_row.EROR_MESG, 
                 l_row.SEND_TYPE, l_row.BULK_NUMB FROM dual)
          WHERE CODE = l_row.CODE; 
      ELSIF l_oprtType = '002' THEN
         -- Activate Msgb
         UPDATE MESSAGE_BOX
            SET STAT = '002'
          WHERE CODE = l_row.CODE;
         NULL;
      ELSIF l_oprtType = '003' THEN
         -- Deactivte Msgb
         UPDATE MESSAGE_BOX
            SET STAT = '001'
          WHERE CODE = l_row.CODE;
      ELSIF l_oprtType = '004' THEN
         -- Update send date msgb
         UPDATE MESSAGE_BOX
            SET SEND_DATE = l_row.SEND_DATE
          WHERE CODE = l_row.CODE;
      ELSIF l_oprtType = '005' THEN
         -- Update Target (Phone number, ChatId, ...) Msgb
         UPDATE MESSAGE_BOX
            SET PHON_NUMB = l_row.PHON_NUMB,
                CHAT_ID = l_row.CHAT_ID
          WHERE CODE = l_row.CODE;
      ELSIF l_oprtType = '006' THEN 
         -- Update Visit Msgb
         UPDATE MESSAGE_BOX
            SET VIST_STAT = l_row.VIST_STAT
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
            
      l_row MESSAGE_BOX%ROWTYPE;
      l_forcStat VARCHAR(3);
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json     
      l_forcStat := l_in.GET_STRING('forcstat');
      L_row.CODE := l_in.GET_STRING('CODE');
      
      IF l_forcStat = '002' THEN 
         DELETE MESSAGE_BOX
          WHERE CODE = l_row.CODE;
      ELSIF l_forcStat = '001' THEN 
         UPDATE MESSAGE_BOX
            SET DEL_DATE = SYSDATE
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

END DML_MSGB_PKG;

/
