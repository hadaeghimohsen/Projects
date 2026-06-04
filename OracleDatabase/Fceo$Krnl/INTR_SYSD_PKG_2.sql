--------------------------------------------------------
--  DDL for Package INTR_SYSD_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_SYSD_PKG" AS
/******************************************************************************
   NAME:       EXTR_USRA_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION SAVE_SYSD_U(p_in CLOB) RETURN CLOB;

END INTR_SYSD_PKG;

/
