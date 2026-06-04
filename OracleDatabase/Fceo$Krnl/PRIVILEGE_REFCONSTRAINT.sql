--------------------------------------------------------
--  Ref Constraints for Table PRIVILEGE
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."PRIVILEGE" ADD CONSTRAINT "FK_PRVL_BOXP" FOREIGN KEY ("BOXP_CODE")
	  REFERENCES "FCEO$KRNL"."BOX_PRIVILEGE" ("CODE") ENABLE;
  ALTER TABLE "FCEO$KRNL"."PRIVILEGE" ADD CONSTRAINT "FK_PRVL_SYS" FOREIGN KEY ("SYS_CODE")
	  REFERENCES "FCEO$KRNL"."SYSTEM_APPLICATION" ("CODE") ENABLE;
