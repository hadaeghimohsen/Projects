--------------------------------------------------------
--  Ref Constraints for Table ROLE_PRIVILEGE_HISTORY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."ROLE_PRIVILEGE_HISTORY" ADD CONSTRAINT "FK_RLPH_ROLP" FOREIGN KEY ("ROLP_CODE")
	  REFERENCES "FCEO$KRNL"."ROLE_PRIVILEGE" ("CODE") ENABLE;
