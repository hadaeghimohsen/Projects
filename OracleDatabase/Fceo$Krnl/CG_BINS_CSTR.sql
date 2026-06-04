--------------------------------------------------------
--  DDL for Trigger CG$BINS_CSTR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BINS_CSTR" 
BEFORE INSERT
ON CONNECTION_STRING 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$BINS_CSTR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$BINS_CSTR
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 10:58:37 AM, and 10/04/2025 10:58:37 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      CONNECTION_STRING (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.CODE := SYS_GUID;
   SELECT NVL(:N.STAT, '002'),
          NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     INTO :N.STAT,
          :N.CRET_BY
     FROM dual;
   :N.CRET_DATE := SYSDATE;
   -- "User Id={0};Password={1};Data Source={2}:{3}/{4};Pooling=true;Min Pool Size=1;Max Pool Size=20;Connection Lifetime=60;";
   SELECT PBLC_COMN_PKG.STR_FRMT_U(
            'User Id={0};Password={1};Data Source={2}:{3}/{4};Pooling=true;Min Pool Size=1;Max Pool Size=20;Connection Lifetime=60;',
            SYS.ODCIVARCHAR2LIST(
               a.SCHM_NAME, 
               '{0}',           
               a.HOST_IP_ADRS,
               a.PORT_NUMB,
               a.SID
            )
          )
     INTO :N.CNCT_STRN_DNRM
     FROM DATASOURCE A
    WHERE a.CODE = :N.DSRC_CODE;
   
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$BINS_CSTR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BINS_CSTR" ENABLE;
