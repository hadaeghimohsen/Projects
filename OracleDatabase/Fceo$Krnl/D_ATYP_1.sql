--------------------------------------------------------
--  DDL for View D$ATYP
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "FCEO$KRNL"."D$ATYP" ("VALU", "DOMN_DESC") AS 
  SELECT VALU, DOMN_DESC FROM APP_STATIC_DOMAIN A WHERE A.CODE = 'D ATYP'
;
