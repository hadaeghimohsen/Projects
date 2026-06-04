--------------------------------------------------------
--  DDL for Trigger CG$BUPD_BRDC
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_BRDC" 
BEFORE UPDATE
ON BROADCAST_CONFIG 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BUPD_BRDC
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/06/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BUPD_BRDC
      Sysdate:         10/06/2025
      Date and Time:   10/06/2025, 2:23:33 PM, and 10/06/2025 2:23:33 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      BROADCAST_CONFIG (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.MDFY_BY
     from dual;
   update broadcast_config
      set DFLT_STAT = '001'
    where :N.DFLT_STAT = '002'
      and CODE != :N.CODE
      and BRDC_TYPE = :N.BRDC_TYPE;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BUPD_BRDC;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_BRDC" ENABLE;
