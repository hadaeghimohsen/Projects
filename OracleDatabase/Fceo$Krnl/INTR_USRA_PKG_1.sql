--------------------------------------------------------
--  DDL for Package INTR_USRA_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_USRA_PKG" AS
/******************************************************************************
   NAME:       INTR_USRA_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_APPLICATION
******************************************************************************/

  FUNCTION INIT_USRA_U(p_in CLOB) RETURN CLOB;

END INTR_USRA_PKG;

/
