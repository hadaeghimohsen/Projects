--------------------------------------------------------
--  Constraints for Table NEWS
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."NEWS" MODIFY ("CODE" NOT NULL ENABLE);
  ALTER TABLE "FCEO$KRNL"."NEWS" ADD CONSTRAINT "PK_NEWS" PRIMARY KEY ("CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "FCEO_KRNL_TS"  ENABLE;
