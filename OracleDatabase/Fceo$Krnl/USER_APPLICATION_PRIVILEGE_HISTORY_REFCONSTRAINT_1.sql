--------------------------------------------------------
--  Ref Constraints for Table USER_APPLICATION_PRIVILEGE_HISTORY
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."USER_APPLICATION_PRIVILEGE_HISTORY" ADD CONSTRAINT "FK_UAPH_UAPR" FOREIGN KEY ("UAPR_CODE")
	  REFERENCES "FCEO$KRNL"."USER_APPLICATION_PRIVILEGE" ("CODE") ENABLE;
