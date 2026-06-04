--------------------------------------------------------
--  DDL for Trigger CG$BUPD_CSTR
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "FCEO$KRNL"."CG$BUPD_CSTR" 
BEFORE UPDATE
ON CONNECTION_STRING 
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:       CG$AUPD_CSTR
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/04/2025      hadaeghi       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     CG$AUPD_CSTR
      Sysdate:         10/04/2025
      Date and Time:   10/04/2025, 11:40:41 AM, and 10/04/2025 11:40:41 AM
      Username:        hadaeghi (set in TOAD Options, Proc Templates)
      Table Name:      CONNECTION_STRING (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   :N.MDFY_DATE := sysdate;
   select NVL(APP_CNTX_PKG.GET_CNTX_U('userappname'), USER)
     into :N.MDFY_BY
     from dual;
   
   if :N.STAT = '002' then 
      if NVL(:N.CNCT_STRN_DNRM, '') = '' THEN 
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
      END IF;
   ELSE 
      :N.CNCT_STRN_DNRM := NULL;
   END if;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END CG$AUPD_CSTR;
/
ALTER TRIGGER "FCEO$KRNL"."CG$BUPD_CSTR" ENABLE;
