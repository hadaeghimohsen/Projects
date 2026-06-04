--------------------------------------------------------
--  DDL for Index PK_RLPH
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_RLPH" ON "FCEO$KRNL"."ROLE_PRIVILEGE_HISTORY" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
