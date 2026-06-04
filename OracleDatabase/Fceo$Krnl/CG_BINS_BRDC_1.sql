--------------------------------------------------------
--  DDL for Trigger CG$BINS_BRDC
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_BRDC" 
BEFORE INSERT
ON BROADCAST_CONFIG 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_BRDC
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/06/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_BRDC
      Sysdate:         10/06/2025
      Date and Time:   10/06/2025, 1:24:11 PM, and 10/06/2025 1:24:11 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      BROADCAST_CONFIG (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/

BEGIN
   :N.CODE := SYS_GUID;
   :N.CRET_DATE := SYSDATE;
   :N.BGWK_STAT := '001';
   :N.BGWK_INTR := 5000;
   :N.SLEP_INTR := 10000;
   :N.PING_HOST := 'www.google.com';
   :N.SEND_STAT := '001';
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.CRET_BY
     from dual;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_BRDC;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_BRDC" ENABLE;
