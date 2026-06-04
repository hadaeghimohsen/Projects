--------------------------------------------------------
--  DDL for View V#USRA_CSTR_DSRC
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "FCEO$KRNL"."V#USRA_CSTR_DSRC" ("USRA_CODE", "USER_APP_NAME", "SCHM_NAME", "ROOT_NAME", "SYS_CODE", "STAT", "HOST_IP_ADRS", "PORT_NUMB", "ROOT_DESC", "CNCT_STRN_DNRM", "PASS_WORD", "SALT_KEY") AS 
  SELECT A.CODE,
       A.USER_APP_NAME,
       c.SCHM_NAME,
       c.ROOT_NAME,
       c.SYS_CODE,
       b.STAT,
       c.HOST_IP_ADRS,
       c.PORT_NUMB,       
       c.ROOT_DESC,       
       b.CNCT_STRN_DNRM,
       C.PASS_WORD,
       C.SALT_KEY
  FROM USER_APPLICATION A, CONNECTION_STRING b, DATASOURCE C
 WHERE     a.CODE = b.USRA_CODE
       AND c.CODE = b.DSRC_CODE
       AND a.STAT = '002'
       AND c.STAT = '002'
       AND b.CNCT_STRN_DNRM IS NOT NULL
;
