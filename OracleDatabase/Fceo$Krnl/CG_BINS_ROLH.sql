--------------------------------------------------------
--  DDL for Trigger CG$BINS_ROLH
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_ROLH" 
BEFORE INSERT
ON ROLE_HISTORY 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_ROLH
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/08/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_ROLH
      Sysdate:         10/08/2025
      Date and Time:   10/08/2025, 11:29:14 AM, and 10/08/2025 11:29:14 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE_HISTORY (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYs_guid;
   :N.CRET_DATE := sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_ROLH;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_ROLH" ENABLE;
