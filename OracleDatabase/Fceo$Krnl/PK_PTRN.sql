--------------------------------------------------------
--  DDL for Index PK_PTRN
--------------------------------------------------------

  CREATE UNIQUE INDEX "FCEO$KRNL"."PK_PTRN" ON "FCEO$KRNL"."PAYMENT_TRANSACTION" ("CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS" ;
