--------------------------------------------------------
--  DDL for Trigger CG$AUPD_ROLE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$AUPD_ROLE" 
AFTER UPDATE
ON ROLE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AUPD_ROLE
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/08/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AUPD_ROLE
      Sysdate:         10/08/2025
      Date and Time:   10/08/2025, 11:30:13 AM, and 10/08/2025 11:30:13 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   if :N.STAT != :O.STAT then 
      insert into role_history(ROLE_CODE, CHNG_STAT)
      values (:N.CODE, :N.STAT);
   end if;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AUPD_ROLE;
/
ALTER TRIGGER "FCEO$KRNL"."CG$AUPD_ROLE" ENABLE;
