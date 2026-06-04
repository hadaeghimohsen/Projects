--------------------------------------------------------
--  DDL for Trigger CG$BINS_GROP
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_GROP" 
BEFORE INSERT
ON GROUPING 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AINS_GROP
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AINS_GROP
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 11:59:21 AM, and 10/04/2025 11:59:21 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      GROUPING (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_guid;
   :N.CRET_DATE := sysdate;
   Select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AINS_GROP;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_GROP" ENABLE;
