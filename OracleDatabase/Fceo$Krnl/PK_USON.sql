--------------------------------------------------------
--  DDL for Index PK_USON
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_USON" ON "FCEO$KRNL"."USER_HOST_SESSION" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
