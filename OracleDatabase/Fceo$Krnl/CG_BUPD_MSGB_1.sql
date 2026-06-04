--------------------------------------------------------
--  DDL for Trigger CG$BUPD_MSGB
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_MSGB" 
BEFORE UPDATE
ON MESSAGE_BOX 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BUPD_MSGB
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/07/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BUPD_MSGB
      Sysdate:         10/07/2025
      Date and Time:   10/07/2025, 12:09:39 PM, and 10/07/2025 12:09:39 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      MESSAGE_BOX (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   IF :N.VIST_STAT = '002' THEN 
      :N.VIST_DATE := SYSDATE;
   ELSE
      :N.VIST_DATE := NULL;
   END IF;
   :N.MDFY_DATE := sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.MDFY_BY
     from dual;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BUPD_MSGB;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_MSGB" ENABLE;
