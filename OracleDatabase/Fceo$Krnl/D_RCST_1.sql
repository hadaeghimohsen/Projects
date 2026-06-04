--------------------------------------------------------
--  DDL for View D$RCST
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "FCEO$KRNL"."D$RCST" ("VALU", "DOMN_DESC") AS 
  SELECT VALU, DOMN_DESC FROM APP_STATIC_DOMAIN A WHERE A.CODE = 'D RCST'
;
