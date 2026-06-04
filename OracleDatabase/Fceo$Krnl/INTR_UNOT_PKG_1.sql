--------------------------------------------------------
--  DDL for Package INTR_UNOT_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_UNOT_PKG" AS
/******************************************************************************
   NAME:       EXTR_UNOT_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION UNOT_INIT_U(p_in CLOB) RETURN CLOB;     

END INTR_UNOT_PKG;

/
