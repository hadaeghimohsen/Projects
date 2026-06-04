--------------------------------------------------------
--  Ref Constraints for Table ROLE_SYSTEM_REPORT_HISTORY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."ROLE_SYSTEM_REPORT_HISTORY" ADD CONSTRAINT "FK_SRRH_RLSR" FOREIGN KEY ("RLSR_CODE")
	  REFERENCES "FCEO$KRNL"."ROLE_SYSTEM_REPORT" ("CODE") ENABLE;
