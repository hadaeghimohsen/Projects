--------------------------------------------------------
--  DDL for Package INTR_BOXP_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_BOXP_PKG" AS
/******************************************************************************
   NAME:       EXTR_BOXP_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION BOXP_INIT_U(p_in CLOB) RETURN CLOB;     

END INTR_BOXP_PKG;

/
