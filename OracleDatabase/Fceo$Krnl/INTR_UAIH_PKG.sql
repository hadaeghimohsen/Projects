--------------------------------------------------------
--  DDL for Package INTR_UAIH_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."INTR_UAIH_PKG" AS
/******************************************************************************
   NAME:       INTR_UAIH_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION_INSTANCE_HISTORY.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_APPLICATION_INSTANCE_HISTORY
******************************************************************************/

  FUNCTION INIT_UAIH_U(p_in CLOB) RETURN CLOB;

END INTR_UAIH_PKG;

/
