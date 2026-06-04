--------------------------------------------------------
--  DDL for Index PK_HINF
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_HINF" ON "FCEO$KRNL"."HOST_INFORMATION" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
