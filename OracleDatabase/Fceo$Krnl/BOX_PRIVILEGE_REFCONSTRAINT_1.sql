--------------------------------------------------------
--  Ref Constraints for Table BOX_PRIVILEGE
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."BOX_PRIVILEGE" ADD CONSTRAINT "FK_BOXP_SYS" FOREIGN KEY ("SYS_CODE")
	  REFERENCES "FCEO$KRNL"."SYSTEM_APPLICATION" ("CODE") ENABLE;
