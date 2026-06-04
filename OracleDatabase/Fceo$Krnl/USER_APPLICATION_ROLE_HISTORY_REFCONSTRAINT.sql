--------------------------------------------------------
--  Ref Constraints for Table USER_APPLICATION_ROLE_HISTORY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."USER_APPLICATION_ROLE_HISTORY" ADD CONSTRAINT "FK_UARH_UARL" FOREIGN KEY ("UARL_CODE")
	  REFERENCES "FCEO$KRNL"."USER_APPLICATION_ROLE" ("CODE") ENABLE;
