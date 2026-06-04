--------------------------------------------------------
--  DDL for View D$ACTV
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "FCEO$KRNL"."D$ACTV" ("VALU", "DOMN_DESC") AS 
  SELECT VALU, DOMN_DESC FROM APP_STATIC_DOMAIN A WHERE A.CODE = 'D ACTV'
;
