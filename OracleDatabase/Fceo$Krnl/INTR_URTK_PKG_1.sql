--------------------------------------------------------
--  DDL for Package INTR_URTK_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_URTK_PKG" AS
/******************************************************************************
   NAME:       INTR_URTK_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_REFRESH_TOKEN.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_REFRESH_TOKEN
******************************************************************************/

  FUNCTION INIT_URTK_U(p_in CLOB) RETURN CLOB;

END INTR_URTK_PKG;

/
