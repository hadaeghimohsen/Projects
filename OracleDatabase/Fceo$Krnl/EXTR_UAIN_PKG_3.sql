--------------------------------------------------------
--  DDL for Package Body EXTR_UAIN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_UAIN_PKG" AS
/******************************************************************************
   NAME:       EXTR_UAIN_PKG
   PURPOSE:    This package provides storage processing procedures and functions
               that can be invoked externally in order to apply operations
               on table USER_APPLICATION_INSTANCE.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/30/2025      hadaeghi       1. Created this package for USER_APPLICATION_INSTANCE
******************************************************************************/

   FUNCTION INIT_UAIN_U(p_in CLOB) RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
      l_row USER_APPLICATION%ROWTYPE; 
   BEGIN
      -- Parse ورودی
      -- get column data from json
      l_row.USER_APP_NAME := JSON_VALUE(p_in, '$.USER_APP_NAME');
      l_row.EMAL_ADRS := JSON_VALUE(p_in, '$.EMAL_ADRS');
      
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
               'sqlbacktrac' VALUE l_backtrac,
               'input' VALUE p_in
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;
   
   FUNCTION LIST_UAIN_U(p_in CLOB) RETURN CLOB
   IS
      l_out CLOB;
      l_data CLOB;
      l_user_name USER_APPLICATION.USER_APP_NAME%TYPE;
      l_oper_type VARCHAR2(3);
      l_page_numb NUMBER;
      l_page_size USER_APPLICATION.VIEW_PAGE_SIZE%TYPE;
      l_offset NUMBER;
      l_total_count NUMBER;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
   BEGIN
      l_user_name := APP_CNTX_PKG.GET_CNTX_U('userappname');
      l_oper_type := JSON_VALUE(p_in, '$.operation.type' NULL ON ERROR);
      l_page_numb := TO_NUMBER(JSON_VALUE(p_in, '$.pagenumb' NULL ON ERROR));
      IF l_page_numb IS NULL OR l_page_numb < 1 THEN l_page_numb := 1; END IF;

      BEGIN
         SELECT NVL(VIEW_PAGE_SIZE, 20) INTO l_page_size
         FROM USER_APPLICATION WHERE USER_APP_NAME = l_user_name;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_page_size := 20; END;

      IF l_oper_type = '001' THEN
         SELECT COUNT(*) INTO l_total_count
         FROM USER_APPLICATION_INSTANCE T
         WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.USRA_CODE' NULL ON ERROR) IS NULL
                OR UPPER(RAWTOHEX(T.USRA_CODE)) LIKE '%' || UPPER(JSON_VALUE(p_in, '$.filter.USRA_CODE' NULL ON ERROR)) || '%')
           AND (JSON_VALUE(p_in, '$.filter.UINS_CODE' NULL ON ERROR) IS NULL
                OR UPPER(RAWTOHEX(T.UINS_CODE)) LIKE '%' || UPPER(JSON_VALUE(p_in, '$.filter.UINS_CODE' NULL ON ERROR)) || '%')
           AND (JSON_VALUE(p_in, '$.filter.CODE' NULL ON ERROR) IS NULL
                OR UPPER(RAWTOHEX(T.CODE)) LIKE '%' || UPPER(JSON_VALUE(p_in, '$.filter.CODE' NULL ON ERROR)) || '%')
           AND (JSON_VALUE(p_in, '$.filter.STAT' NULL ON ERROR) IS NULL
                OR T.STAT LIKE '%' || JSON_VALUE(p_in, '$.filter.STAT' NULL ON ERROR) || '%');

         l_offset := (l_page_numb - 1) * l_page_size;

         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'USRA_CODE' VALUE RAWTOHEX(T.USRA_CODE),
                  'USRA_NAME' VALUE UA.USER_APP_NAME,
                  'USRA_DESC' VALUE UA.USER_APP_DESC,
                  'UINS_CODE' VALUE RAWTOHEX(T.UINS_CODE),
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'STAT' VALUE T.STAT,
                  'STAT_DESC' VALUE ST.DOMN_DESC,
                  'CRET_BY' VALUE T.CRET_BY,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE, 'YYYY-MM-DD HH24:MI:SS'),
                  'MDFY_BY' VALUE T.MDFY_BY,
                  'MDFY_DATE' VALUE TO_CHAR(T.MDFY_DATE, 'YYYY-MM-DD HH24:MI:SS')
               )
               ORDER BY CASE WHEN T.STAT = '002' THEN 0 ELSE 1 END, T.CRET_DATE DESC
               RETURNING CLOB
            ) INTO l_data
            FROM USER_APPLICATION_INSTANCE T
            LEFT JOIN USER_APPLICATION UA ON T.USRA_CODE = UA.CODE
            LEFT JOIN D$ACTV ST ON T.STAT = ST.VALU
            WHERE T.STAT IS NOT NULL
              AND (JSON_VALUE(p_in, '$.filter.USRA_CODE' NULL ON ERROR) IS NULL
                   OR UPPER(RAWTOHEX(T.USRA_CODE)) LIKE '%' || UPPER(JSON_VALUE(p_in, '$.filter.USRA_CODE' NULL ON ERROR)) || '%')
              AND (JSON_VALUE(p_in, '$.filter.UINS_CODE' NULL ON ERROR) IS NULL
                   OR UPPER(RAWTOHEX(T.UINS_CODE)) LIKE '%' || UPPER(JSON_VALUE(p_in, '$.filter.UINS_CODE' NULL ON ERROR)) || '%')
              AND (JSON_VALUE(p_in, '$.filter.CODE' NULL ON ERROR) IS NULL
                   OR UPPER(RAWTOHEX(T.CODE)) LIKE '%' || UPPER(JSON_VALUE(p_in, '$.filter.CODE' NULL ON ERROR)) || '%')
              AND (JSON_VALUE(p_in, '$.filter.STAT' NULL ON ERROR) IS NULL
                   OR T.STAT LIKE '%' || JSON_VALUE(p_in, '$.filter.STAT' NULL ON ERROR) || '%')
            OFFSET l_offset ROWS FETCH NEXT l_page_size ROWS ONLY;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_data := '[]'; END;

         IF l_data IS NULL THEN l_data := '[]'; END IF;

         l_out := JSON_OBJECT(
            'rspncode' VALUE '0', 'rspndesc' VALUE 'success',
            'elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt),
            'page_numb' VALUE l_page_numb, 'page_size' VALUE l_page_size,
            'total_count' VALUE l_total_count,
            'data' VALUE JSON_QUERY(l_data, '$')
         );
      ELSE
         l_out := JSON_OBJECT('rspncode' VALUE '-1',
            'rspndesc' VALUE 'invalid operation type: ' || l_oper_type);
      END IF;
      RETURN l_out;
   EXCEPTION WHEN OTHERS THEN
      l_sqlcode := SQLCODE; l_sqlerrm := SQLERRM;
      l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      l_out := JSON_OBJECT('rspncode' VALUE '-1', 'rspndesc' VALUE l_sqlerrm,
         'sqlcode' VALUE l_sqlcode, 'backtrac' VALUE l_backtrac);
      RETURN l_out;
   END LIST_UAIN_U;
  
   FUNCTION COPY_UAIN_U(p_in CLOB) RETURN CLOB
   IS       
      l_out CLOB;
      l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;

      -- Manage exception handling
      l_sqlcode  NUMBER;
      l_sqlerrm  VARCHAR2(4000);
      l_backtrac VARCHAR2(4000);
            
   BEGIN
      -- Parse ورودی
      -- get column data from json      
      MERGE INTO USER_APPLICATION_INSTANCE T
      USING (SELECT JSON_VALUE(p_in, '$.USRA_CODE') AS USRA_CODE, JSON_VALUE(p_in, '$.UINS_CODE') AS UINS_CODE FROM DUAL) S
      ON (T.USRA_CODE = S.USRA_CODE AND 
          T.UINS_CODE = S.UINS_CODE)
      WHEN NOT MATCHED THEN 
         INSERT (USRA_CODE, UINS_CODE) VALUES (S.USRA_CODE, S.UINS_CODE);
      
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
               'sqlbacktrac' VALUE l_backtrac,
               'input' VALUE p_in
           )
           INTO l_out
           FROM DUAL;
         RETURN l_out;
      END;
   END;

END EXTR_UAIN_PKG;

/
