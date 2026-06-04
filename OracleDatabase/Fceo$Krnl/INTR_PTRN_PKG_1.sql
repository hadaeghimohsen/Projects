--------------------------------------------------------
--  DDL for Package INTR_PTRN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_PTRN_PKG" AS
/******************************************************************************
   NAME:       INTR_PTRN_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table PAYMENT_TRANSACTION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for PAYMENT_TRANSACTION
******************************************************************************/

  FUNCTION INIT_PTRN_U(p_in CLOB) RETURN CLOB;

END INTR_PTRN_PKG;

/
