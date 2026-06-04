--------------------------------------------------------
--  DDL for Trigger CG$BINS_NEWS
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_NEWS" 
BEFORE INSERT
ON NEWS 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_NEWS
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_NEWS
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 12:54:57 PM, and 10/04/2025 12:54:57 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      NEWS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := sys_guid;
   :N.CRET_DATE := sysdate;
   select nvl(:N.STAT, '002'),
          NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.STAT,
          :N.CRET_BY
    from dual;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_NEWS;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_NEWS" ENABLE;
