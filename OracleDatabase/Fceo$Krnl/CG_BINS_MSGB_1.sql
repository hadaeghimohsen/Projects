--------------------------------------------------------
--  DDL for Trigger CG$BINS_MSGB
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_MSGB" 
BEFORE INSERT
ON MESSAGE_BOX 
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
lr_brdc BROADCAST_CONFIG%ROWTYPE;
BEGIN
   SELECT *
     INTO lr_brdc
     FROM BROADCAST_CONFIG bc
    WHERE bc.CODE = :N.BRDC_CODE;
    
   :N.CODE := SYS_GUID;
   :N.CRET_DATE := SYSDATE;
   :N.VIST_STAT := '001';
   :N.BRDC_TYPE_DNRM := lr_brdc.BRDC_TYPE;
      
   -- IF Active => Active
   -- IF Deactive => SemiActive
   SELECT DECODE(lr_brdc.SEND_STAT, '002', '002', '001', '003' ),
          LENGTH(:N.MESG_TEXT),
          DECODE(MOD(LENGTH(:N.MESG_TEXT), 70), 
                 0, 
                 LENGTH(:N.MESG_TEXT) / 70, 
                 LENGTH(:N.MESG_TEXT) / 70 + 1),
          NVL(:N.SEND_DATE, sysdate),
          decode(:N.BULK_NUMB, NULL, '001', '002'),
          NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     INTO :N.STAT,
          :N.MESG_LENT,
          :N.PAGE_NUMB_DNRM,
          :N.SEND_DATE,
          :N.SEND_TYPE,
          :N.CRET_BY
     FROM dual;
   
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_BRDC;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_MSGB" ENABLE;
