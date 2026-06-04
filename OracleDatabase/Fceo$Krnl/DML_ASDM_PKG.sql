--------------------------------------------------------
--  DDL for Package DML_ASDM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."DML_ASDM_PKG" AS
/******************************************************************************
   NAME:       DML_ASDM_PKG
   PURPOSE:    INSERT, UPDATE, DELETE

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/29/2025      hadaeghi       1. Created this package for APP_STATIC_DOMAIN
******************************************************************************/

   FUNCTION INS_OPRT_U(p_in clob) RETURN clob;
   FUNCTION UPD_OPRT_U(p_in clob) RETURN clob;
   FUNCTION DEL_OPRT_U(p_in clob) RETURN clob;

END DML_ASDM_PKG;

/
