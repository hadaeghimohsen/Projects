--------------------------------------------------------
--  DDL for Trigger CG$BUPD_DSRC
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_DSRC" 
BEFORE UPDATE
ON DATASOURCE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BUPD_DSRC
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/12/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BUPD_DSRC
      Sysdate:         10/12/2025
      Date and Time:   10/12/2025, 10:37:01 AM, and 10/12/2025 10:37:01 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      DATASOURCE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := sysdate;
   SELECT NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.MDFY_BY 
     from dual;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BUPD_DSRC;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_DSRC" ENABLE;
