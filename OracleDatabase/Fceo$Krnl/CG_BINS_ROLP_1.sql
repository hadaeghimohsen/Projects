--------------------------------------------------------
--  DDL for Trigger CG$BINS_ROLP
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_ROLP" 
BEFORE INSERT
ON ROLE_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_ROLP
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_ROLP
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 1:32:33 PM, and 10/04/2025 1:32:33 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      ROLE_PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_guid;
   :N.CRET_DATE := SYsdate;
   select Nvl(:N.STAT, '002'),
          NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.STAT,
          :N.CRET_BY
     from dual;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_ROLP;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_ROLP" ENABLE;
