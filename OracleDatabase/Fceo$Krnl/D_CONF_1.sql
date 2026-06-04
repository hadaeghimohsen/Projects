--------------------------------------------------------
--  DDL for View D$CONF
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "FCEO$KRNL"."D$CONF" ("VALU", "DOMN_DESC") AS 
  SELECT VALU, DOMN_DESC FROM APP_STATIC_DOMAIN A WHERE A.CODE = 'D CONF'
;
