--------------------------------------------------------
--  DDL for Trigger CG$BUPD_UAPR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_UAPR" 
BEFORE UPDATE
ON USER_APPLICATION_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BUPD_UAPR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BUPD_UAPR
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:20:59 PM, and 10/04/2025 2:20:59 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_APPLICATION_PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := sysdate;
   SELECT NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     INTO :N.MDFY_BY
     FROM dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BUPD_UAPR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_UAPR" ENABLE;
