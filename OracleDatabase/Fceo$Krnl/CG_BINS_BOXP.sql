--------------------------------------------------------
--  DDL for Trigger CG$BINS_BOXP
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_BOXP" 
BEFORE INSERT
ON BOX_PRIVILEGE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 8:21:47 AM, and 10/04/2025 8:21:47 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      BOX_PRIVILEGE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN   
   :N.CODE := SYS_GUID;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_BOXP" ENABLE;
