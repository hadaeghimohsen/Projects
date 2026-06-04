--------------------------------------------------------
--  DDL for Package EXTR_GPUA_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_GPUA_PKG" AS
/******************************************************************************
   NAME:       EXTR_GPUA_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table GROUPING_USER_APPLICATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for GROUPING_USER_APPLICATION
******************************************************************************/

   FUNCTION INIT_GPUA_U(p_in CLOB) RETURN CLOB;
   FUNCTION JOIN_GPUA_U(p_in CLOB) RETURN CLOB;
   FUNCTION LEFT_GPUA_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_GPUA_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACV_GPUA_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_GPUA_U(p_in CLOB) RETURN CLOB;

END EXTR_GPUA_PKG;

/
