--------------------------------------------------------
--  DDL for Package EXTR_SYS_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_SYS_PKG" AS
/******************************************************************************
   NAME:       EXTR_SYS_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table SYSTEM_APPLICATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for SYSTEM_APPLICATION
******************************************************************************/

   FUNCTION INIT_SYS_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_SYS_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_SYS_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_SYS_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_SYS_U(p_in CLOB) RETURN CLOB;

END EXTR_SYS_PKG;

/
