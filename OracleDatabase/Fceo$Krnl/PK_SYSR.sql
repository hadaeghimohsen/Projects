--------------------------------------------------------
--  DDL for Index PK_SYSR
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_SYSR" ON "FCEO$KRNL"."SYSTEM_REPORT" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
