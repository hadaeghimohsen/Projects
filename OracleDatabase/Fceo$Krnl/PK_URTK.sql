--------------------------------------------------------
--  DDL for Index PK_URTK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_URTK" ON "FCEO$KRNL"."USER_REFRESH_TOKEN" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
