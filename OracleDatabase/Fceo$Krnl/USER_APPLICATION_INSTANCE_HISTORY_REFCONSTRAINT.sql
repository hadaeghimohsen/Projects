--------------------------------------------------------
--  Ref Constraints for Table USER_APPLICATION_INSTANCE_HISTORY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."USER_APPLICATION_INSTANCE_HISTORY" ADD CONSTRAINT "FK_UAIH_UAIN" FOREIGN KEY ("UAIN_CODE")
	  REFERENCES "FCEO$KRNL"."USER_APPLICATION_INSTANCE" ("CODE") ENABLE;
