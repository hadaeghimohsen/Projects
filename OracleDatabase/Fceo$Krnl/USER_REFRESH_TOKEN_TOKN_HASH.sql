--------------------------------------------------------
--  DDL for Index USER_REFRESH_TOKEN_TOKN_HASH
--------------------------------------------------------

  CREATE INDEX "FCEO$KRNL"."USER_REFRESH_TOKEN_TOKN_HASH" ON "FCEO$KRNL"."USER_REFRESH_TOKEN" ("TOKN_HASH") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
