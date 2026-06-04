--------------------------------------------------------
--  DDL for Trigger CG$BINS_ADYM
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_ADYM" 
BEFORE INSERT
ON APP_DYNAMIC_DOMAIN 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_ADYM
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_ADYM
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 9:23:05 AM, and 10/04/2025 9:23:05 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      APP_DYNAMIC_DOMAIN (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_GUID;
   SELECT NVL(:N.REGN_LANG, '054'),
          NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     INTO :N.REGN_LANG,
          :N.CRET_BY
     FROM DUAL;
   SELECT NVL(MAX(RWNO), 0) + 1
     INTO :N.RWNO
     FROM APP_DYNAMIC_DOMAIN
    WHERE DOMN_NAME = :N.DOMN_NAME;
      

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_ADYM;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_ADYM" ENABLE;
