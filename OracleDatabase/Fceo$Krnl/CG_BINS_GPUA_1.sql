--------------------------------------------------------
--  DDL for Trigger CG$BINS_GPUA
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_GPUA" 
BEFORE INSERT
ON GROUPING_USER_APPLICATION 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AINS_GPUA
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AINS_GPUA
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 12:20:50 PM, and 10/04/2025 12:20:50 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      GROUPING_USER_APPLICATION (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := Sys_guid;
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
END CG$AINS_GPUA;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_GPUA" ENABLE;
