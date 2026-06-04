--------------------------------------------------------
--  DDL for Index PK_ROLH
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_ROLH" ON "FCEO$KRNL"."ROLE_HISTORY" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
