--------------------------------------------------------
--  DDL for Trigger CG$BINS_DSRC
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_DSRC" 
BEFORE INSERT
ON DATASOURCE 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AINS_DSRC
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AINS_DSRC
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 11:49:45 AM, and 10/04/2025 11:49:45 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      DATASOURCE (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_GUID;
   :N.CRET_DATE := SYSDATE;   
   SELECT NVL(:N.STAT, '002'),
          NVL(:N.PORT_NUMB, 1521),
          NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     INTO :N.STAT,
          :N.PORT_NUMB,
          :N.CRET_BY
     FROM dual;
      
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AINS_DSRC;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_DSRC" ENABLE;
