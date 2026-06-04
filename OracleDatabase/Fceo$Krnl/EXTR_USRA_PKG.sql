--------------------------------------------------------
--  DDL for Package EXTR_USRA_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_USRA_PKG" AS
/******************************************************************************
   NAME:       EXTR_USRA_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_APPLICATION
******************************************************************************/

  FUNCTION INIT_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION LGIN_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION LGOT_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION CRET_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION REMV_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION UPDT_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION ACTV_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION DACT_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION UPDT_PSWD_U(p_in CLOB) RETURN CLOB;
  FUNCTION UPDT_PINC_U(p_in CLOB) RETURN CLOB;
  FUNCTION DUPL_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION INST_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION CHCK_PRIV_U(p_in CLOB) RETURN CLOB;
  FUNCTION ENBL_TOTP_U(p_in CLOB) RETURN CLOB;
  FUNCTION DSBL_TOTP_U(p_in CLOB) RETURN CLOB;
  FUNCTION GETP_USRA_U(p_in CLOB) RETURN CLOB;
  FUNCTION LIST_USRA_U(p_in CLOB) RETURN CLOB;

END EXTR_USRA_PKG;

/
