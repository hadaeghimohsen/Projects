--------------------------------------------------------
--  DDL for Trigger CG$AUPD_UAPR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$AUPD_UAPR" 
AFTER UPDATE
ON USER_APPLICATION_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AUPD_UAPR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AUPD_UAPR
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:58:00 PM, and 10/04/2025 2:58:00 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_APPLICATION_PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   if :N.STAT != :O.STAT then 
      INSERT into User_application_privilege_history(UAPR_CODE, CHNG_STAT)
      values(:N.CODE, :N.STAT);
   end if;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AUPD_UAPR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$AUPD_UAPR" ENABLE;
