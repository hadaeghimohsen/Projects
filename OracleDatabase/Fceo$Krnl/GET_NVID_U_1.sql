--------------------------------------------------------
--  DDL for Function GET_NVID_U
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "FCEO$KRNL"."GET_NVID_U" 
RETURN VARCHAR2
IS
    v_rlst VARCHAR2(50);
BEGIN
    SELECT TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3')
           || LPAD(SYS_CONTEXT('USERENV','SESSIONID'), 6, '0')
      INTO v_rlst
      FROM dual;

    RETURN v_rlst;
END;

/
