--------------------------------------------------------
--  DDL for Package Body EXTR_SYSR_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_SYSR_PKG" AS
   FUNCTION INIT_SYSR_U(p_in CLOB) RETURN CLOB IS
      l_out CLOB; l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      l_sqlcode NUMBER; l_sqlerrm VARCHAR2(4000); l_backtrac VARCHAR2(4000);
   BEGIN
      RETURN JSON_OBJECT('rspncode' VALUE '0','rspndesc' VALUE 'stub - implement me','elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt));
   EXCEPTION WHEN OTHERS THEN
      l_sqlcode := SQLCODE; l_sqlerrm := SQLERRM;
      l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      RETURN JSON_OBJECT('rspncode' VALUE '-1','rspndesc' VALUE 'failed','sqlerrm' VALUE l_sqlerrm);
   END;


   FUNCTION LIST_SYSR_U(p_in CLOB) RETURN CLOB IS
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
         SELECT COUNT(*) INTO l_total_count FROM SYSTEM_REPORT T
         WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.SYSR_NAME' NULL ON ERROR) IS NULL OR T.SYSR_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.SYSR_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.CMNT' NULL ON ERROR) IS NULL OR T.CMNT LIKE '%' || JSON_VALUE(p_in, '$.filter.CMNT' NULL ON ERROR) || '%');
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'SYSR_NAME' VALUE T.SYSR_NAME,
                  'CMNT' VALUE T.CMNT,
                  'PATH_ADRS' VALUE T.PATH_ADRS,
                  'STAT' VALUE T.STAT,
                  'STAT_DESC' VALUE SD.DOMN_DESC,
                  'RPRT_ENGN_TYPE' VALUE T.RPRT_ENGN_TYPE,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'CRET_BY' VALUE T.CRET_BY
               )
               ORDER BY CASE WHEN T.STAT = '002' THEN 0 ELSE 1 END, T.CRET_DATE DESC RETURNING CLOB
            ) INTO l_data
            FROM SYSTEM_REPORT T
            LEFT JOIN D$ACTV SD ON T.STAT = SD.VALU
            WHERE T.STAT IS NOT NULL
           AND (JSON_VALUE(p_in, '$.filter.SYSR_NAME' NULL ON ERROR) IS NULL OR T.SYSR_NAME LIKE '%' || JSON_VALUE(p_in, '$.filter.SYSR_NAME' NULL ON ERROR) || '%') AND (JSON_VALUE(p_in, '$.filter.CMNT' NULL ON ERROR) IS NULL OR T.CMNT LIKE '%' || JSON_VALUE(p_in, '$.filter.CMNT' NULL ON ERROR) || '%')
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
END EXTR_SYSR_PKG;

/
