--------------------------------------------------------
--  DDL for Trigger CG$BINS_PRVL
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_PRVL" 
BEFORE INSERT
ON FCEO$KRNL.PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_PRVL
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_PRVL
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 8:31:35 AM, and 10/04/2025 8:31:35 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_GUID;
   :N.STAT := '002';
   IF :N.SYS_CODE IS NULL THEN 
      SELECT SYS_CODE
        INTO :N.SYS_CODE
        FROM BOX_PRIVILEGE 
       WHERE CODE = :N.BOXP_CODE;
   END IF;
   SELECT NVL(MAX(RWNO), 0) + 1
     INTO :N.RWNO
     FROM PRIVILEGE
    WHERE SYS_CODE = :N.SYS_CODE;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_PRVL;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_PRVL" ENABLE;
