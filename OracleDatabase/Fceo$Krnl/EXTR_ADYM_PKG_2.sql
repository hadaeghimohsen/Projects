--------------------------------------------------------
--  DDL for Package EXTR_ADYM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_ADYM_PKG" AS
/******************************************************************************
   NAME:       EXTR_ADYM_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table APP_DYNAMIC_DOMAIN.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for APP_DYNAMIC_DOMAIN
******************************************************************************/

   FUNCTION INIT_ADYM_U(p_in CLOB) RETURN CLOB;     
   FUNCTION CRET_ADYM_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_ADYM_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_ADYM_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_ADYM_U(p_in CLOB) RETURN CLOB;

END EXTR_ADYM_PKG;

/
