--------------------------------------------------------
--  DDL for Package Body EXTR_HINF_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_HINF_PKG" AS
/******************************************************************************
   NAME:       EXTR_HINF_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table HOST_INFORMATION.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/01/2025      hadaeghi       1. Created this package for HOST_INFORMATION
******************************************************************************/

   FUNCTION INIT_HINF_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row HOST_INFORMATION%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      
      
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
        )
        INTO l_out
        FROM DUAL;
      RETURN l_out;
   EXCEPTION
      WHEN OTHERS THEN
      BEGIN
         l_sqlcode  := SQLCODE;
         l_sqlerrm   := SQLERRM;
         l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         SELECT 
           JSON_OBJECT(
               'rspncode' VALUE '-1',
               'rspndesc' VALUE 'failed',
               'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
               'sqlerrm' VALUE l_sqlerrm,
               'sqlcode' VALUE l_sqlcode,
               'sqlbacktrac' VALUE l_backtrac
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;
   
   FUNCTION REGS_HINF_U(p_in CLOB) 
   RETURN CLOB
   IS 
      l_in JSON_OBJECT_T;
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row HOST_INFORMATION%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      l_in := JSON_OBJECT_T.parse(p_in);
      
      -- get column data from json
      
      
      -- Serialize برگردوندن به CLOB
      SELECT 
        JSON_OBJECT(
            'rspncode' VALUE '0',
            'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt)               
        )
        INTO l_out
        FROM DUAL;
      RETURN l_out;
   EXCEPTION
      WHEN OTHERS THEN
      BEGIN
         l_sqlcode  := SQLCODE;
         l_sqlerrm   := SQLERRM;
         l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         SELECT 
           JSON_OBJECT(
               'rspncode' VALUE '-1',
               'rspndesc' VALUE 'failed',
               'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
               'sqlerrm' VALUE l_sqlerrm,
               'sqlcode' VALUE l_sqlcode,
               'sqlbacktrac' VALUE l_backtrac
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;


   FUNCTION LIST_HINF_U(p_in CLOB) RETURN CLOB IS
      l_out CLOB; l_data CLOB;
      l_user_name USER_APPLICATION.USER_APP_NAME%TYPE;
      l_oper_type VARCHAR2(3);
      l_page_numb NUMBER; l_page_size USER_APPLICATION.VIEW_PAGE_SIZE%TYPE;
      l_offset NUMBER; l_total_count NUMBER;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      l_sqlcode NUMBER; l_sqlerrm VARCHAR2(4000); l_backtrac VARCHAR2(4000);
   BEGIN
      l_user_name := APP_CNTX_PKG.GET_CNTX_U('userappname');
      l_oper_type := JSON_VALUE(p_in, '$.operation.type' NULL ON ERROR);
      l_page_numb := TO_NUMBER(JSON_VALUE(p_in, '$.pagenumb' NULL ON ERROR));
      IF l_page_numb IS NULL OR l_page_numb < 1 THEN l_page_numb := 1; END IF;
      BEGIN SELECT NVL(VIEW_PAGE_SIZE, 20) INTO l_page_size FROM USER_APPLICATION WHERE USER_APP_NAME = l_user_name;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_page_size := 20; END;
      IF l_oper_type = '001' THEN
         SELECT COUNT(*) INTO l_total_count FROM HOST_INFORMATION T
         WHERE T.ACTV_STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.DEV_NAME' NULL ON ERROR) IS NULL OR T.DEV_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.DEV_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.IP_ADRS' NULL ON ERROR) IS NULL OR T.IP_ADRS LIKE '%' || JSON_VALUE(p_in, '$.filter.IP_ADRS' NULL ON ERROR) || '%');
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'DEV_NAME' VALUE T.DEV_NAME,
                  'IP_ADRS' VALUE T.IP_ADRS,
                  'OS_VERS' VALUE T.OS_VERS,
                  'ACTV_STAT' VALUE T.ACTV_STAT,
                  'ACTV_STAT_DESC' VALUE SD.DOMN_DESC,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE T.CRET_BY
               )
               ORDER BY CASE WHEN T.ACTV_STAT = '002' THEN 0 ELSE 1 END, T.CRET_DATE DESC RETURNING CLOB
            ) INTO l_data
            FROM HOST_INFORMATION T
            LEFT JOIN D$ACTV SD ON T.ACTV_STAT = SD.VALU
            WHERE T.ACTV_STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.DEV_NAME' NULL ON ERROR) IS NULL OR T.DEV_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.DEV_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.IP_ADRS' NULL ON ERROR) IS NULL OR T.IP_ADRS LIKE '%' || JSON_VALUE(p_in, '$.filter.IP_ADRS' NULL ON ERROR) || '%')
            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_data := '[]'; END;
         IF l_data IS NULL THEN l_data := '[]'; END IF;
         l_out := JSON_OBJECT('rspncode' VALUE '0','rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'page_numb' VALUE l_page_numb,'page_size' VALUE l_page_size,
            'total_count' VALUE l_total_count,
            'data' VALUE JSON_QUERY(l_data, '$'));
      ELSE l_out := JSON_OBJECT('rspncode' VALUE '-1','rspndesc' VALUE 'invalid operation type: ' || l_oper_type); END IF;
      RETURN l_out;
   EXCEPTION WHEN OTHERS THEN
      l_sqlcode := SQLCODE; l_sqlerrm := SQLERRM;
      l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      RETURN JSON_OBJECT('rspncode' VALUE '-1','rspndesc' VALUE 'failed',
         'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
         'sqlerrm' VALUE l_sqlerrm,'sqlcode' VALUE l_sqlcode,
         'sqlbacktrac' VALUE l_backtrac,'input' VALUE p_in);
   END;
END EXTR_HINF_PKG;

/
