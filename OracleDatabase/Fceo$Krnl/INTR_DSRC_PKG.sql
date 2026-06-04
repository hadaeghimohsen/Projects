--------------------------------------------------------
--  DDL for Package INTR_DSRC_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_DSRC_PKG" AS
/******************************************************************************
   NAME:       EXTR_DSRC_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package.
******************************************************************************/

   FUNCTION DSRC_INIT_U(p_in CLOB) RETURN CLOB;     

END INTR_DSRC_PKG;

/
