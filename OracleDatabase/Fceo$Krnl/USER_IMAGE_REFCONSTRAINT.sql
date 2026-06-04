--------------------------------------------------------
--  Ref Constraints for Table USER_IMAGE
--------------------------------------------------------

  ALTER TABLE "FCEO$KRNL"."USER_IMAGE" ADD CONSTRAINT "FK_UIMG_USRA" FOREIGN KEY ("USRA_CODE")
	  REFERENCES "FCEO$KRNL"."USER_APPLICATION" ("CODE") ENABLE;
