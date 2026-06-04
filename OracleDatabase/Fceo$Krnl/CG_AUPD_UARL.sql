--------------------------------------------------------
--  DDL for Trigger CG$AUPD_UARL
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$AUPD_UARL" 
AFTER UPDATE
ON USER_APPLICATION_ROLE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AUPD_USRR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/06/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AUPD_USRR
      Sysdate:         10/06/2025
      Date and Time:   10/06/2025, 2:58:25 PM, and 10/06/2025 2:58:25 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_APPLICATION_ROLE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   IF :N.STAT != :O.STAT THEN 
      INSERT INTO USER_APPLICATION_ROLE_HISTORY(UARL_CODE, CHNG_STAT)
      VALUES(:N.CODE, :N.STAT);
   END IF;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AUPD_USRR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$AUPD_UARL" ENABLE;
