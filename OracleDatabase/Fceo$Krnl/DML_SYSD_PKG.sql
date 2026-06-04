--------------------------------------------------------
--  DDL for Package DML_SYSD_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."DML_SYSD_PKG" AS
/******************************************************************************
   NAME:       DML_ADYM_PKG
   PURPOSE:    INSERT, UPDATE,DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for APP_DYNAMIC_DOMAIN
******************************************************************************/

  FUNCTION INS_OPRT_U(p_in clob) RETURN clob;

END DML_SYSD_PKG;

/
