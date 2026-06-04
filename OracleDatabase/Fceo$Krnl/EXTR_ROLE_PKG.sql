--------------------------------------------------------
--  DDL for Package EXTR_ROLE_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_ROLE_PKG" AS
/******************************************************************************
   NAME:       EXTR_ROLE_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table ROLE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for ROLE
******************************************************************************/

   FUNCTION INIT_ROLE_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_ROLE_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_ROLE_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_ROLE_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_ROLE_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACT_ROLE_U(p_in CLOB) RETURN CLOB;
   FUNCTION DUPL_ROLE_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_ROLE_U(p_in CLOB) RETURN CLOB;

END EXTR_ROLE_PKG;

/
