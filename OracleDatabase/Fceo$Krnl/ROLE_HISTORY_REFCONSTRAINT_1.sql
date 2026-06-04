--------------------------------------------------------
--  Ref Constraints for Table ROLE_HISTORY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."ROLE_HISTORY" ADD CONSTRAINT "FK_ROLH_ROLE" FOREIGN KEY ("ROLE_CODE")
	  REFERENCES "FCEO$KRNL"."ROLE" ("CODE") ENABLE;
