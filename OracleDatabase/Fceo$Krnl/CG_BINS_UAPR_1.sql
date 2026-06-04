--------------------------------------------------------
--  DDL for Trigger CG$BINS_UAPR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_UAPR" 
BEFORE INSERT
ON USER_APPLICATION_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_UAPR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_UAPR
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:19:22 PM, and 10/04/2025 2:19:22 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_APPLICATION_PRIVILEGE (set in the "New PL/SQL Object" dialog)
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
END CG$BINS_UAPR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_UAPR" ENABLE;
