--------------------------------------------------------
--  DDL for Package EXTR_MSGB_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_MSGB_PKG" AS
/******************************************************************************
   NAME:       EXTR_MSGB_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table MESSAGE_BOX.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for MESSAGE_BOX
******************************************************************************/

   FUNCTION INIT_MSGB_U(p_in CLOB) RETURN CLOB;     
   FUNCTION CRET_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACT_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION CSDT_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION CTRG_MSGB_U(p_in CLOB) RETURN CLOB;
   FUNCTION VIST_MSGB_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_MSGB_U(p_in CLOB) RETURN CLOB;

END EXTR_MSGB_PKG;

/
