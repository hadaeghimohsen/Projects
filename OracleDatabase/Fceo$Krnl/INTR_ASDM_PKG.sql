--------------------------------------------------------
--  DDL for Package INTR_ASDM_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_ASDM_PKG" AS
/******************************************************************************
   NAME:       EXTR_ASDM_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION INIT_ASDM_U(p_in CLOB) RETURN CLOB;     

END INTR_ASDM_PKG;

/
