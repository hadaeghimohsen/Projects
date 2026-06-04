--------------------------------------------------------
--  DDL for Trigger CG$BINS_UNOT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_UNOT" 
BEFORE INSERT
ON USER_NOTIFICATION 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_UNOT
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_UNOT
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 2:16:53 PM, and 10/04/2025 2:16:53 PM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      USER_NOTIFICATION (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := sys_guid;
   SELECT nvl(:N.READ_STAT, '001'),
          nvl(:N.PIN_STAT, '001')
     into :N.READ_STAT,
          :N.PIN_STAT
     FROM dual;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_UNOT;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_UNOT" ENABLE;
