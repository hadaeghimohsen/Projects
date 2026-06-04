--------------------------------------------------------
--  DDL for Package INTR_HINF_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_HINF_PKG" AS
/******************************************************************************
   NAME:       INTR_HINF_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table HOST_INFORMATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for HOST_INFORMATION
******************************************************************************/

  FUNCTION INIT_HINF_U(p_in CLOB) RETURN CLOB;

END INTR_HINF_PKG;

/
