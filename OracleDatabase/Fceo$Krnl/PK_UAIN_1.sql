--------------------------------------------------------
--  DDL for Index PK_UAIN
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_UAIN" ON "FCEO$KRNL"."USER_APPLICATION_INSTANCE" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
