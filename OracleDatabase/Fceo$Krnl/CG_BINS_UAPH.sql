--------------------------------------------------------
--  DDL for Trigger CG$BINS_UAPH
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_UAPH" 
BEFORE INSERT
ON USER_APPLICATION_PRIVILEGE_HISTORY 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_UAPH
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_UAPH
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:05:56 PM, and 10/04/2025 2:05:56 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_APPLICATION_PRIVILEGE_HISTORY (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := sys_guid;
   :N.CRET_DATE := SYSdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_UAPH;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_UAPH" ENABLE;
