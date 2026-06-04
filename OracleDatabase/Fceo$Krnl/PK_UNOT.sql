--------------------------------------------------------
--  DDL for Index PK_UNOT
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_UNOT" ON "FCEO$KRNL"."USER_NOTIFICATION" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
