--------------------------------------------------------
--  DDL for Package EXTR_BOXP_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_BOXP_PKG" AS
/******************************************************************************
   NAME:       EXTR_BOXP_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table BOX_PRIVILEGE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for BOX_PRIVILEGE
******************************************************************************/

   FUNCTION INIT_BOXP_U(p_in CLOB) RETURN CLOB;     
   FUNCTION CRET_BOXP_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_BOXP_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_BOXP_U(p_in CLOB) RETURN CLOB;
   
   FUNCTION LIST_BOXP_U(p_in CLOB) RETURN CLOB;

END EXTR_BOXP_PKG;

/
