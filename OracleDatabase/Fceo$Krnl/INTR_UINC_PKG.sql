--------------------------------------------------------
--  DDL for Package INTR_UINC_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_UINC_PKG" AS
/******************************************************************************
   NAME:       INTR_UINC_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION_INSTANCE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_APPLICATION_INSTANCE
******************************************************************************/

  FUNCTION INIT_UINC_U(p_in CLOB) RETURN CLOB;

END INTR_UINC_PKG;

/
