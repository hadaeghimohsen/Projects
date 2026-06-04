--------------------------------------------------------
--  DDL for Trigger CG$BUPD_ROLE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_ROLE" 
BEFORE UPDATE
ON ROLE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BUPD_ROLE
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BUPD_ROLE
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 1:08:52 PM, and 10/04/2025 1:08:52 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := sysdate;
   select nvl(APP_CNTX_PKG.GET_CNTX_U('userappname'), user)
     into :N.MDFY_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BUPD_ROLE;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_ROLE" ENABLE;
