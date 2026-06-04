--------------------------------------------------------
--  DDL for Package INTR_SYSR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_SYSR_PKG" AS
/******************************************************************************
   NAME:       INTR_SYSR_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table SYSTEM_REPORT.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for SYSTEM_REPORT
******************************************************************************/

  FUNCTION INIT_SYSR_U(p_in CLOB) RETURN CLOB;

END INTR_SYSR_PKG;

/
