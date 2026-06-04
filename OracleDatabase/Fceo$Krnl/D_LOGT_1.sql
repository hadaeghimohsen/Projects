--------------------------------------------------------
--  DDL for View D$LOGT
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "FCEO$KRNL"."D$LOGT" ("VALU", "DOMN_DESC") AS 
  SELECT VALU, DOMN_DESC FROM APP_STATIC_DOMAIN A WHERE A.CODE = 'D LOGT'
;
