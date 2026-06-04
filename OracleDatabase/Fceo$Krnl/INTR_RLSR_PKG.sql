--------------------------------------------------------
--  DDL for Package INTR_RLSR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_RLSR_PKG" AS
/******************************************************************************
   NAME:       INTR_RLSR_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table ROLE_SYSTEM_REPORT.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for ROLE_SYSTEM_REPORT
******************************************************************************/

  FUNCTION INIT_RLSR_U(p_in CLOB) RETURN CLOB;

END INTR_RLSR_PKG;

/
