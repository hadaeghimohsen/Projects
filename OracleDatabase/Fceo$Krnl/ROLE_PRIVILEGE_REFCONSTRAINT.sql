--------------------------------------------------------
--  Ref Constraints for Table ROLE_PRIVILEGE
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."ROLE_PRIVILEGE" ADD CONSTRAINT "FK_ROLP_ROLE" FOREIGN KEY ("ROLE_CODE")
	  REFERENCES "FCEO$KRNL"."ROLE" ("CODE") ENABLE;
  ALTER TABLE "FCEO$KRNL"."ROLE_PRIVILEGE" ADD CONSTRAINT "FK_ROLP_PRVL" FOREIGN KEY ("PRVL_CODE")
	  REFERENCES "FCEO$KRNL"."PRIVILEGE" ("CODE") ENABLE;
