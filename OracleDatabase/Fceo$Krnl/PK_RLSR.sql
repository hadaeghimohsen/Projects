--------------------------------------------------------
--  DDL for Index PK_RLSR
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_RLSR" ON "FCEO$KRNL"."ROLE_SYSTEM_REPORT" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
