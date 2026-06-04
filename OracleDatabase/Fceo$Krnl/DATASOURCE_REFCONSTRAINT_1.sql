--------------------------------------------------------
--  Ref Constraints for Table DATASOURCE
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."DATASOURCE" ADD CONSTRAINT "FK_DSRC_SYS" FOREIGN KEY ("SYS_CODE")
	  REFERENCES "FCEO$KRNL"."SYSTEM_APPLICATION" ("CODE") ENABLE;
