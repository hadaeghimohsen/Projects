--------------------------------------------------------
--  DDL for Package DML_SYS_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."DML_SYS_PKG" AS
/******************************************************************************
   NAME:       DML_UAPR_PKG
   PURPOSE:    INSERT, UPDATE, DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for SYSTEM_APPLICATION
******************************************************************************/

  FUNCTION INS_OPRT_U(p_in clob) RETURN clob;
  FUNCTION UPD_OPRT_U(p_in clob) RETURN clob;
  FUNCTION DEL_OPRT_U(p_in clob) RETURN clob;

END DML_SYS_PKG;

/
