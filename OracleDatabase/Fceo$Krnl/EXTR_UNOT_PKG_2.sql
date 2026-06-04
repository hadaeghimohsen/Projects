--------------------------------------------------------
--  DDL for Package EXTR_UNOT_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_UNOT_PKG" AS
/******************************************************************************
   NAME:       EXTR_UNOT_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_NOTIFICATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for USER_NOTIFICATION
******************************************************************************/

   FUNCTION INIT_UNOT_U(p_in CLOB) RETURN CLOB;     
   FUNCTION INBX_UNOT_U(p_in CLOB) RETURN CLOB;
   FUNCTION READ_UNOT_U(p_in CLOB) RETURN CLOB;
   FUNCTION PINT_UNOT_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPIN_UNOT_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_UNOT_U(p_in CLOB) RETURN CLOB;

END EXTR_UNOT_PKG;

/
