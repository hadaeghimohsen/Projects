--------------------------------------------------------
--  DDL for Package EXTR_PGAT_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_PGAT_PKG" AS
/******************************************************************************
   NAME:       EXTR_PGAT_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table PAYMENT_GATEWAY.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for PAYMENT_GATEWAY
******************************************************************************/

  FUNCTION INIT_PGAT_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_PGAT_U(p_in CLOB) RETURN CLOB;

END EXTR_PGAT_PKG;

/
