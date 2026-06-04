--------------------------------------------------------
--  DDL for Package EXTR_UAPR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_UAPR_PKG" AS
/******************************************************************************
   NAME:       EXTR_UAPR_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION_PRIVILEGE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for USER_APPLICATION_PRIVILEGE
******************************************************************************/

   FUNCTION INIT_UAPR_U(p_in CLOB) RETURN CLOB;
   FUNCTION GRNT_UAPR_U(p_in CLOB) RETURN CLOB;
   FUNCTION RVOK_UAPR_U(p_in CLOB) RETURN CLOB;
   FUNCTION CHCK_UAPR_U(p_in CLOB) RETURN CLOB;
   FUNCTION COPY_UAPR_U(p_in CLOB) RETURN CLOB;
   
   FUNCTION LIST_UAPR_U(p_in CLOB) RETURN CLOB;

END EXTR_UAPR_PKG;

/
