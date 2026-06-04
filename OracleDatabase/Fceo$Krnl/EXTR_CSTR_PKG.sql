--------------------------------------------------------
--  DDL for Package EXTR_CSTR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_CSTR_PKG" AS
/******************************************************************************
   NAME:       EXTR_CSTR_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table CONNECTION_STRING.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for CONNECTION_STRING
******************************************************************************/

   FUNCTION INIT_CSTR_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_CSTR_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_CSTR_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_CSTR_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACT_CSTR_U(p_in CLOB) RETURN CLOB;
   FUNCTION GET_CSTR_U(p_in CLOB) RETURN CLOB;
   
   FUNCTION LIST_CSTR_U(p_in CLOB) RETURN CLOB;

END EXTR_CSTR_PKG;

/
