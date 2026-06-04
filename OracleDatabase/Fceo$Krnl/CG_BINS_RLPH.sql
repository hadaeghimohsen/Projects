--------------------------------------------------------
--  DDL for Trigger CG$BINS_RLPH
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_RLPH" 
BEFORE INSERT
ON ROLE_PRIVILEGE_HISTORY 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$_BINS_RLPH
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$_BINS_RLPH
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:04:03 PM, and 10/04/2025 2:04:03 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE_PRIVILEGE_HISTORY (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := sys_guid;
   :N.CRET_DATE := sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$_BINS_RLPH;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_RLPH" ENABLE;
