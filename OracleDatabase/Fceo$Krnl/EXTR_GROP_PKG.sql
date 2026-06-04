--------------------------------------------------------
--  DDL for Package EXTR_GROP_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_GROP_PKG" AS
/******************************************************************************
   NAME:       EXTR_GROP_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table GROUPING.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for GROUPING
******************************************************************************/

   FUNCTION INIT_GROP_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_GROP_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_GROP_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_GROP_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_GROP_U(p_in CLOB) RETURN CLOB;

END EXTR_GROP_PKG;

/
