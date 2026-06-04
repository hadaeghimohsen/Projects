--------------------------------------------------------
--  DDL for Index PK_UAPH
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_UAPH" ON "FCEO$KRNL"."USER_APPLICATION_PRIVILEGE_HISTORY" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
