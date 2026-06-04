--------------------------------------------------------
--  DDL for Package EXTR_UIMG_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_UIMG_PKG" AS
/******************************************************************************
   NAME:       EXTR_UIMG_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_IMAGE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for USER_IMAGE
******************************************************************************/

   FUNCTION INIT_UIMG_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPLD_UIMG_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_UIMG_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_UIMG_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_UIMG_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACT_UIMG_U(p_in CLOB) RETURN CLOB;        

   FUNCTION LIST_UIMG_U(p_in CLOB) RETURN CLOB;

END EXTR_UIMG_PKG;

/
