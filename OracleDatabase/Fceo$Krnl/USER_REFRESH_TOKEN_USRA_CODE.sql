--------------------------------------------------------
--  DDL for Index USER_REFRESH_TOKEN_USRA_CODE
--------------------------------------------------------

  CREATE INDEX "FCEO$KRNL"."USER_REFRESH_TOKEN_USRA_CODE" ON "FCEO$KRNL"."USER_REFRESH_TOKEN" ("USRA_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
