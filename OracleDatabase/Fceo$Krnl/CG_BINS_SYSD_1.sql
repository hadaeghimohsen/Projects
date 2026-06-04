--------------------------------------------------------
--  DDL for Trigger CG$BINS_SYSD
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_SYSD" 
BEFORE INSERT
ON SYSTEM_AUDIT 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_SYSD
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/05/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_SYSD
      Sysdate:         10/05/2025
      Date and Time:   10/05/2025, 12:59:07 PM, and 10/05/2025 12:59:07 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      SYSTEM_AUDIT (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_guid;
   :N.CRET_DATE := SYSdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from duaL;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_SYSD;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_SYSD" ENABLE;
