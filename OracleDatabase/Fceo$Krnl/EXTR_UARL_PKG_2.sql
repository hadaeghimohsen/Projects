--------------------------------------------------------
--  DDL for Package EXTR_UARL_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_UARL_PKG" AS
/******************************************************************************
   NAME:       EXTR_UARL_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION_ROLE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for USER_APPLICATION_ROLE
******************************************************************************/

   FUNCTION INIT_UARL_U(p_in CLOB) RETURN CLOB;     
   FUNCTION GRNT_UARL_U(p_in CLOB) RETURN CLOB;
   FUNCTION RVOK_UARL_U(p_in CLOB) RETURN CLOB;
   FUNCTION CHCK_UARL_U(p_in CLOB) RETURN CLOB;
   FUNCTION COPY_UARL_U(p_in CLOB) RETURN CLOB;
   
   FUNCTION LIST_UARL_U(p_in CLOB) RETURN CLOB;

END EXTR_UARL_PKG;

/
