--------------------------------------------------------
--  DDL for Trigger CG$BUPD_ROLP
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_ROLP" 
BEFORE UPDATE
ON ROLE_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BUPD_ROLP
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BUPD_ROLP
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 1:35:55 PM, and 10/04/2025 1:35:55 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE_PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.MDFY_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BUPD_ROLP;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_ROLP" ENABLE;
