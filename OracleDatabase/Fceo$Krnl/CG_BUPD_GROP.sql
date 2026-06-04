--------------------------------------------------------
--  DDL for Trigger CG$BUPD_GROP
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_GROP" 
BEFORE INSERT
ON GROUPING 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AUPD_GROP
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AUPD_GROP
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 12:05:34 PM, and 10/04/2025 12:05:34 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      GROUPING (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := Sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.MDFY_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AUPD_GROP;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_GROP" ENABLE;
