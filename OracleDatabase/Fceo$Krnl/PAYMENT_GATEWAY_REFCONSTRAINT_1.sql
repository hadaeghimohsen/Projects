--------------------------------------------------------
--  Ref Constraints for Table PAYMENT_GATEWAY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."PAYMENT_GATEWAY" ADD CONSTRAINT "FK_PGAT_HINF" FOREIGN KEY ("HINF_CODE")
	  REFERENCES "FCEO$KRNL"."HOST_INFORMATION" ("CODE") ENABLE;
