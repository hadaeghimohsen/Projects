--------------------------------------------------------
--  Ref Constraints for Table ROLE
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."ROLE" ADD CONSTRAINT "FK_ROLE_SYS" FOREIGN KEY ("SYS_CODE")
	  REFERENCES "FCEO$KRNL"."SYSTEM_APPLICATION" ("CODE") ENABLE;
