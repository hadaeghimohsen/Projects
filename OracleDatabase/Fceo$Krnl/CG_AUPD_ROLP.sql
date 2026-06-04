--------------------------------------------------------
--  DDL for Trigger CG$AUPD_ROLP
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$AUPD_ROLP" 
AFTER UPDATE
ON ROLE_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AUPD_ROLP
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AUPD_ROLP
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:49:41 PM, and 10/04/2025 2:49:41 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE_PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   IF :N.STAT != :O.STAT THEN
      INSERT into role_privilege_history(ROLP_CODE, CHNG_STAT)
      values(:N.CODE, :N.STAT);
   END IF;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AUPD_ROLP;
/
ALTER TRIGGER "FCEO$KRNL"."CG$AUPD_ROLP" ENABLE;
