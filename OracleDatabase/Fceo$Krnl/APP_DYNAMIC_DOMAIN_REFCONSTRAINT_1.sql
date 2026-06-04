--------------------------------------------------------
--  Ref Constraints for Table APP_DYNAMIC_DOMAIN
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."APP_DYNAMIC_DOMAIN" ADD CONSTRAINT "FK_PADD_ADDM" FOREIGN KEY ("REF_CODE")
	  REFERENCES "FCEO$KRNL"."APP_DYNAMIC_DOMAIN" ("CODE") ENABLE;
