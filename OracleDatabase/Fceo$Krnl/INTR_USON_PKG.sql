--------------------------------------------------------
--  DDL for Package INTR_USON_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_USON_PKG" AS
/******************************************************************************
   NAME:       INTR_USON_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_HOST_SESSION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_HOST_SESSION
******************************************************************************/

  FUNCTION INIT_USON_U(p_in CLOB) RETURN CLOB;

END INTR_USON_PKG;

/
