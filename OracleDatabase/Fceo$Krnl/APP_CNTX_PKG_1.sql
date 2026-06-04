--------------------------------------------------------
--  DDL for Package Body APP_CNTX_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."APP_CNTX_PKG" AS
   PROCEDURE INIT_CNTX_P(P_in CLOB)
   IS
   BEGIN
      NULL;
   END;
   
   PROCEDURE SET_CNTX_P(p_attr VARCHAR2, p_valu VARCHAR2) IS
   BEGIN
       DBMS_SESSION.SET_CONTEXT('KRNL_APP_CTX', p_attr, p_valu);
   END;
   
   FUNCTION GET_CNTX_U(p_attr VARCHAR2) 
   RETURN VARCHAR2
   IS
   BEGIN
      RETURN SYS_CONTEXT('KRNL_APP_CTX', p_attr);
   END;
   
   PROCEDURE CLER_CNTX_P
   IS
   BEGIN
      DBMS_SESSION.CLEAR_CONTEXT('KRNL_APP_CTX');
   END;
END APP_CNTX_PKG;

/
