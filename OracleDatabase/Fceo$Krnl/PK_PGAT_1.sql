--------------------------------------------------------
--  DDL for Index PK_PGAT
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_PGAT" ON "FCEO$KRNL"."PAYMENT_GATEWAY" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
