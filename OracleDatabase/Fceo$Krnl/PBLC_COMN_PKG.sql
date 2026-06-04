--------------------------------------------------------
--  DDL for Package PBLC_COMN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."PBLC_COMN_PKG" AS
/******************************************************************************
   NAME:       PBLC_COMN_PKG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/07/2025      hadaeghi       1. Created this package.
******************************************************************************/

   -- Get Meta data of table columns with return json string
   FUNCTION GMTJ_TCLM_U(p_in CLOB) RETURN CLOB;
   FUNCTION STR_FRMT_U(p_tmpl VARCHAR2, p_parm SYS.ODCIVARCHAR2LIST) RETURN VARCHAR2;
   FUNCTION STR_ECRP_U(p_inpt VARCHAR2, p_key RAW) RETURN RAW;
   FUNCTION STR_DCRP_U(p_inpt RAW, p_key RAW) RETURN VARCHAR2;
   FUNCTION CNV_CTOB_U(p_clob CLOB) RETURN BLOB;

END PBLC_COMN_PKG;

/
