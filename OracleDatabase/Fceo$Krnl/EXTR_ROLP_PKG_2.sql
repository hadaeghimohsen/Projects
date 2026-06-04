--------------------------------------------------------
--  DDL for Package EXTR_ROLP_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_ROLP_PKG" AS
/******************************************************************************
   NAME:       EXTR_ROLP_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table ROLE_PRIVILEGE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for ROLE_PRIVILEGE
******************************************************************************/

   FUNCTION INIT_ROLP_U(p_in CLOB) RETURN CLOB;
   FUNCTION GRNT_ROLP_U(p_in CLOB) RETURN CLOB;     
   FUNCTION RVOK_ROLP_U(p_in CLOB) RETURN CLOB;
   FUNCTION CHCK_ROLP_U(p_in CLOB) RETURN CLOB;
   FUNCTION COPY_ROLP_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_ROLP_U(p_in CLOB) RETURN CLOB;

END EXTR_ROLP_PKG;

/
