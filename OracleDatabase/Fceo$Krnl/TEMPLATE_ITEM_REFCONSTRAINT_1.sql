--------------------------------------------------------
--  Ref Constraints for Table TEMPLATE_ITEM
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."TEMPLATE_ITEM" ADD CONSTRAINT "FK_TMPI_TBLA" FOREIGN KEY ("TABL_NAME")
	  REFERENCES "FCEO$KRNL"."TABLE_ALIAS" ("TABL_NAME") ENABLE;
