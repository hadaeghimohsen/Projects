--------------------------------------------------------
--  DDL for Package DML_HINF_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."DML_HINF_PKG" AS
/******************************************************************************
   NAME:       DML_HINF_PKG
   PURPOSE:    INSERT, UPDATE,DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for HOST_INFORMATION
******************************************************************************/

  FUNCTION INS_OPRT_U(p_in CLOB) RETURN CLOB;
  FUNCTION UPD_OPRT_U(p_in CLOB) RETURN CLOB;
  FUNCTION DEL_OPRT_U(p_in CLOB) RETURN CLOB;

END DML_HINF_PKG;

/
