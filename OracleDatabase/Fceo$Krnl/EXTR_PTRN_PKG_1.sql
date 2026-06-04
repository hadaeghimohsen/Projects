--------------------------------------------------------
--  DDL for Package Body EXTR_PTRN_PKG
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "FCEO$KRNL"."EXTR_PTRN_PKG" AS
   FUNCTION INIT_PTRN_U(p_in CLOB) RETURN CLOB IS
      l_out CLOB; l_strt PLS_INTEGER := DBMS_UTILITY.GET_TIME;
      l_sqlcode NUMBER; l_sqlerrm VARCHAR2(4000); l_backtrac VARCHAR2(4000);
   BEGIN
      RETURN JSON_OBJECT('rspncode' VALUE '0','rspndesc' VALUE 'stub - implement me','elpstime' VALUE (DBMS_UTILITY.GET_TIME - l_strt));
   EXCEPTION WHEN OTHERS THEN
      l_sqlcode := SQLCODE; l_sqlerrm := SQLERRM;
      l_backtrac := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      RETURN JSON_OBJECT('rspncode' VALUE '-1','rspndesc' VALUE 'failed','sqlerrm' VALUE l_sqlerrm);
   END;


   FUNCTION LIST_PTRN_U(p_in CLOB) RETURN CLOB IS
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
         SELECT COUNT(*) INTO l_total_count FROM PAYMENT_TRANSACTION T
         WHERE (JSON_VALUE(p_in, '$.filter.RESP_DESC' NULL ON ERROR) IS NULL OR T.RESP_DESC LIKE '%' || JSON_VALUE(p_in, '$.filter.RESP_DESC' NULL ON ERROR) || '%');
         l_offset := (l_page_numb - 1) * l_page_size;
         BEGIN
            SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                  'CODE' VALUE RAWTOHEX(T.CODE),
                  'TRAN_DATE' VALUE TO_CHAR(T.TRAN_DATE,'YYYY-MM-DD HH24:MI:SS'),
                  'AMNT' VALUE T.AMNT,
                  'PAY_STAT' VALUE T.PAY_STAT,
                  'PAY_STAT_DESC' VALUE PS.DOMN_DESC,
                  'RESP_DESC' VALUE T.RESP_DESC,
                  'RWNO' VALUE T.RWNO,
                  'TERM_NO' VALUE T.TERM_NO,
                  'TRAN_NO' VALUE T.TRAN_NO,
                  'CRET_DATE' VALUE TO_CHAR(T.CRET_DATE,'YYYY-MM-DD HH24:MI:SS')
               )
               ORDER BY T.TRAN_DATE DESC RETURNING CLOB
            ) INTO l_data
            FROM PAYMENT_TRANSACTION T
            LEFT JOIN D$PMST PS ON T.PAY_STAT = PS.VALU
            WHERE (JSON_VALUE(p_in, '$.filter.RESP_DESC' NULL ON ERROR) IS NULL OR T.RESP_DESC LIKE '%' || JSON_VALUE(p_in, '$.filter.RESP_DESC' NULL ON ERROR) || '%')
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
END EXTR_PTRN_PKG;

/
