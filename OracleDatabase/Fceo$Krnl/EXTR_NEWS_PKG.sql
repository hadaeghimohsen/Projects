--------------------------------------------------------
--  DDL for Package EXTR_NEWS_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."EXTR_NEWS_PKG" AS
/******************************************************************************
   NAME:       EXTR_NEWS_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table NEWS.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for NEWS
******************************************************************************/

   FUNCTION INIT_NEWS_U(p_in CLOB) RETURN CLOB;
   FUNCTION CRET_NEWS_U(p_in CLOB) RETURN CLOB;
   FUNCTION REMV_NEWS_U(p_in CLOB) RETURN CLOB;
   FUNCTION UPDT_NEWS_U(p_in CLOB) RETURN CLOB;
   FUNCTION ACTV_NEWS_U(p_in CLOB) RETURN CLOB;
   FUNCTION DACT_NEWS_U(p_in CLOB) RETURN CLOB;

   FUNCTION LIST_NEWS_U(p_in CLOB) RETURN CLOB;

END EXTR_NEWS_PKG;

/
