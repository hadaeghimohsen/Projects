--------------------------------------------------------
--  Ref Constraints for Table SYSTEM_REPORT
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."SYSTEM_REPORT" ADD CONSTRAINT "FK_SYSR_SYSR" FOREIGN KEY ("SYSR_CODE")
	  REFERENCES "FCEO$KRNL"."SYSTEM_REPORT" ("CODE") ENABLE;
