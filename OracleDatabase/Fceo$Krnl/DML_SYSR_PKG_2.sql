--------------------------------------------------------
--  DDL for Package DML_SYSR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."DML_SYSR_PKG" AS
/******************************************************************************
   NAME:       DML_SYSR_PKG
   PURPOSE:    INSERT, UPDATE,DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for SYSTEM_REPORT
******************************************************************************/

  FUNCTION INS_OPRT_U(p_in CLOB) RETURN CLOB;
  FUNCTION UPD_OPRT_U(p_in CLOB) RETURN CLOB;
  FUNCTION DEL_OPRT_U(p_in CLOB) RETURN CLOB;

END DML_SYSR_PKG;

/
