--------------------------------------------------------
--  DDL for Package EXTR_BRDC_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_BRDC_PKG" AS
/******************************************************************************
   NAME:       EXTR_BRDC_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table BROADCAST_CONFIG.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for BROADCAST_CONFIG
******************************************************************************/

   FUNCTION INIT_BRDC_U(p_in CLOB) RETURN CLOB;     
   FUNCTION CRET_BRDC_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_BRDC_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_BRDC_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_BRDC_U(p_in CLOB) RETURN CLOB;

END EXTR_BRDC_PKG;

/
