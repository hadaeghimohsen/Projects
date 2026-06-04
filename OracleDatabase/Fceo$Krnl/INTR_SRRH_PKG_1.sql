--------------------------------------------------------
--  DDL for Package INTR_SRRH_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_SRRH_PKG" AS
/******************************************************************************
   NAME:       INTR_SRRH_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table ROLE_SYSTEM_REPORT_HISTORY.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for ROLE_SYSTEM_REPORT_HISTORY
******************************************************************************/

  FUNCTION INIT_SRRH_U(p_in CLOB) RETURN CLOB;

END INTR_SRRH_PKG;

/
