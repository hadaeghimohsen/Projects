--------------------------------------------------------
--  DDL for Package EXTR_ASDM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_ASDM_PKG" AS
/******************************************************************************
   NAME:       EXTR_ASDM_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table APP_STATIC_DOMAIN.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for APP_STATIC_DOMAIN
******************************************************************************/

   FUNCTION INIT_ASDM_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_ASDM_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_ASDM_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_ASDM_U(p_in CLOB) RETURN CLOB;
   
   FUNCTION LIST_ASDM_U(p_in CLOB) RETURN CLOB;

END EXTR_ASDM_PKG;

/
