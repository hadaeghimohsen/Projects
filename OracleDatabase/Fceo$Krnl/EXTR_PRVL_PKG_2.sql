--------------------------------------------------------
--  DDL for Package EXTR_PRVL_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_PRVL_PKG" AS
/******************************************************************************
   NAME:       EXTR_PRVL_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table PRIVILEGE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for PRIVILEGE
******************************************************************************/

   FUNCTION INIT_PRVL_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_PRVL_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_PRVL_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_PRVL_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_PRVL_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACT_PRVL_U(p_in CLOB) RETURN CLOB;
   
   FUNCTION LIST_PRVL_U(p_in CLOB) RETURN CLOB;

END EXTR_PRVL_PKG;

/
