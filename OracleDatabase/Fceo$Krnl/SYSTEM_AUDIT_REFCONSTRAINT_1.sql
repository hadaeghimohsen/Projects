--------------------------------------------------------
--  Ref Constraints for Table SYSTEM_AUDIT
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."SYSTEM_AUDIT" ADD CONSTRAINT "FK_SYSD_USRA" FOREIGN KEY ("USRA_CODE")
	  REFERENCES "FCEO$KRNL"."USER_APPLICATION" ("CODE") ENABLE;
