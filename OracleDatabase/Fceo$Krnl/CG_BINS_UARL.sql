--------------------------------------------------------
--  DDL for Trigger CG$BINS_UARL
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_UARL" 
BEFORE INSERT
ON USER_APPLICATION_ROLE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_USRR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/06/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_USRR
      Sysdate:         10/06/2025
      Date and Time:   10/06/2025, 2:48:27 PM, and 10/06/2025 2:48:27 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_APPLICATION_ROLE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := sys_guid;
   :N.CRET_DATE := sysdate;
   :N.STAT := '002';
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_USRR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_UARL" ENABLE;
