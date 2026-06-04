--------------------------------------------------------
--  DDL for Index PK_NEWS
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_NEWS" ON "FCEO$KRNL"."NEWS" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
