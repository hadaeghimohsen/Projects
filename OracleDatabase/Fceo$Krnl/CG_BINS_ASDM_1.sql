--------------------------------------------------------
--  DDL for Trigger CG$BINS_ASDM
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_ASDM" 
BEFORE INSERT
ON APP_STATIC_DOMAIN 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_ASDM
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_ASDM
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 10:20:08 AM, and 10/04/2025 10:20:08 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      APP_STATIC_DOMAIN (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   SELECT NVL(:N.REGN_LANG, '054') 
     INTO :N.REGN_LANG
     FROM dual;

   SELECT NVL(MAX(RWNO), 0) + 1 
     INTO :N.RWNO 
     FROM APP_STATIC_DOMAIN
    WHERE CODE = :N.CODE
      AND REGN_LANG = :N.REGN_LANG;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_ASDM;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_ASDM" ENABLE;
