--------------------------------------------------------
--  DDL for Package EXTR_DSRC_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_DSRC_PKG" AS
/******************************************************************************
   NAME:       EXTR_DSRC_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table DATASOURCE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for DATASOURCE
******************************************************************************/

   FUNCTION INIT_DSRC_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_DSRC_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_DSRC_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_DSRC_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_DSRC_U(p_in CLOB) RETURN CLOB;

END EXTR_DSRC_PKG;

/
