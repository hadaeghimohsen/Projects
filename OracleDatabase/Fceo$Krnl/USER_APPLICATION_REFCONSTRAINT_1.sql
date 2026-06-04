--------------------------------------------------------
--  Ref Constraints for Table USER_APPLICATION
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."USER_APPLICATION" ADD CONSTRAINT "FK_USRA_USRA" FOREIGN KEY ("USRA_CODE")
	  REFERENCES "FCEO$KRNL"."USER_APPLICATION" ("CODE") ENABLE;
