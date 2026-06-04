--------------------------------------------------------
--  DDL for Package APP_CNTX_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "FCEO$KRNL"."APP_CNTX_PKG" AS
   PROCEDURE INIT_CNTX_P(P_in CLOB);
   PROCEDURE SET_CNTX_P(p_attr VARCHAR2, p_valu VARCHAR2);
   function GET_CNTX_U(p_attr VARCHAR2) return varchar2;
   PROCEDURE CLER_CNTX_P;
END APP_CNTX_PKG;

/
