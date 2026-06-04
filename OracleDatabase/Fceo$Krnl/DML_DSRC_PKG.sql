--------------------------------------------------------
--  DDL for Package DML_DSRC_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."DML_DSRC_PKG" AS
/******************************************************************************
   NAME:       DML_DSRC_PKG
   PURPOSE:    INSERT, UPDATE, DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for DATASOURCE
******************************************************************************/

  FUNCTION INS_OPRT_U(p_in clob) RETURN clob;
  FUNCTION UPD_OPRT_U(p_in clob) RETURN clob;
  FUNCTION DEL_OPRT_U(p_in clob) RETURN clob;

END DML_DSRC_PKG;

/
