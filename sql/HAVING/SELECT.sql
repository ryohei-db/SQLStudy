-- =========================================
-- データの歯抜けを探す_SQLite
-- =========================================

SELECT '歯抜けあり' AS gap
FROM SeqTbl
GROUP BY '歯抜けあり'
HAVING COUNT(*) <> MAX(seq);

-- ============================================
-- 歯抜けの最小値を探す_SQLite
-- ============================================

SELECT MIN(seq+1) AS gap
FROM SeqTbl
WHERE (seq+1) NOT IN(SELECT seq FROM SeqTbl);

-- ============================================================
-- 下限値は無視して数値が連続しているかのみを調べる_SQLite
-- ============================================================

SELECT '歯抜けあり' AS gap
FROM SeqTbl
GROUP BY '歯抜けあり'
HAVING COUNT(*) <> MAX(seq) - MIN(seq) + 1;

-- ==============================================================
-- 欠番があってもなくても1行返す_SQLite
-- ==============================================================

SELECT CASE WHEN COUNT(*) = 0 THEN 'テーブルが空です'
            WHEN COUNT(*) <> MAX(seq) - MIN(seq) +1 THEN '歯抜けあり'
            ELSE '連続' END AS gap
FROM SeqTbl;

-- ===============================================================
-- 自分の一つ前の数値がないレコードがあるかの存在チェック_SQLite
-- ===============================================================

SELECT S1.seq
FROM SeqTbl S1
WHERE NOT EXISTS(

    SELECT 1
    FROM SeqTbl S2
    WHERE S1.seq = S2.seq + 1
);

-- ==============================================================
-- 欠番があるか存在をチェックし値を抽出する_SQLite
-- ==============================================================

SELECT S1.seq + 1 AS missing_seq
FROM SeqTbl S1
WHERE S1.seq < (SELECT MAX(seq) FROM SeqTbl)
    AND NOT EXISTS(

        SELECT 1
        FROM SeqTbl S2
        WHERE S1.seq + 1 = S2.seq

    );

-- =================================================================
-- 歯抜けの最小値を探す：テーブルに1がない場合は、１を返す_SQLite
-- =================================================================

SELECT CASE WHEN COUNT(*) = 0 OR MIN(seq) > 1
            THEN 1
            ELSE (
                SELECT MIN(seq + 1) 
                FROM SeqTbl S1
                WHERE NOT EXISTS(
                    SELECT 1
                    FROM SeqTbl S2
                    WHERE S2.seq = S1.seq + 1)           ) END
FROM SeqTbl;

-- ===============================================================
-- 最頻値を求めるSQL : その１_標準SQL
-- ===============================================================

SELECT income,COUNT(*)
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= ALL (

    SELECT COUNT(*)
    FROM Graduates
    GROUP BY income
);

-- ==================================================================
-- 最頻値を求めるSQL : その2_SQLiteへの書き換え_極値関数の利用
-- ==================================================================

SELECT income,COUNT(*) AS cnt
FROM Graduates
GROUP BY income
HAVING COUNT(*) >= (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Graduates
        GROUP BY income
    )
);

-- ====================================================================
-- 提出日にNULLを含まない学部を選択する:その1_SQLite
-- ====================================================================

SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = COUNT(sbmt_date);

-- ====================================================================
-- 提出日にNULLを含まない学部を選択する:その2_CASE式の利用_SQLite
-- ====================================================================

SELECT dpt
FROM Students
GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date IS NOT NULL THEN 1 ELSE 0 END);

-- ======================================================================
-- クラスの75%以上の生徒が80点以上のクラスを選択せよ_SQLite
-- ======================================================================

SELECT class
FROM TestResult 
GROUP BY class
HAVING COUNT(*) * 0.75 <= SUM(CASE WHEN score >= 80 THEN 1 ELSE 0 END) ;

-- =======================================================================
-- 50点以上取った生徒のうち男子の数が女子の数より多いクラスを選択する_SQLite
-- =======================================================================

SELECT class
FROM TestResult
GROUP BY class
HAVING SUM(CASE WHEN sex = '男' AND score >= 50 THEN 1 ELSE 0 END)
     > SUM(CASE WHEN sex = '女' AND score >= 50 THEN 1 ELSE 0 END);

-- =============================================================================
-- 女子の平均点が男子より高いクラスを選択する:その１空集合に対する平均を０で返す_SQLite
-- =============================================================================

SELECT class
FROM TestResult
GROUP BY class
HAVING AVG(CASE WHEN sex ='女'THEN score ELSE 0 END)
    > AVG(CASE WHEN sex ='男' THEN score ELSE 0 END);

-- =================================================================================
--  女子の平均点が男子より高いクラスを選択する:その２空集合に対する平均をNULLで返す_SQLite
-- =================================================================================

SELECT class
FROM TestResult
GROUP BY class
HAVING AVG(CASE WHEN sex = '男' THEN score END) < AVG(CASE WHEN sex ='女' THEN score END);

-- =================================================================================
-- 全称化を述語で表現する:すべてのメンバーが待機中である隊を選択_SQLite
-- =================================================================================

SELECT team_id , member
FROM Teams T1
WHERE NOT EXISTS (

    SELECT *
    FROM Teams T2
    WHERE T1.team_id = T2.team_id AND status <> '待機'
);

-- =====================================================================================
-- 全称文を集合で表現する：すべてのメンバーが待機中である隊を選択する：その１_SQLite
--======================================================================================

SELECT team_id
FROM Teams
GROUP BY team_id
HAVING COUNT(*) = SUM(CASE WHEN status = '待機'THEN 1 ELSE 0 END);

-- ======================================================================================
-- 全称文を集合で表現する：すべてのメンバーが待機中である隊を選択する：その2_SQLite
-- ======================================================================================

SELECT team_id
FROM Teams
GROUP BY team_id
HAVING MAX(status) = '待機' AND MIN(status) = '待機';

-- ==================================================================================================
--  全称文を集合で表現する：すべてのメンバーが待機中である隊を選択する：その３_SQLite
-- 総員、待機状態かをチームごと一覧表示する
-- ==================================================================================================

SELECT team_id, CASE WHEN MAX(status) = '待機' AND MIN(status) = '待機' THEN '出動可能'
                    ELSE 'メンバー足りません' END AS status

FROM Teams
GROUP BY team_id;

-- ===================================================================================================
-- 資材のダブっている拠点を選択する:ダブっている集合を抽出：その１_SQLite
-- ===================================================================================================

SELECT center
FROM Materials
GROUP BY center
HAVING COUNT(material) <> COUNT(DISTINCT material);

-- ============================================================================================
-- 資材のダブっている拠点を選択する:ダブっている集合を抽出：資材が余っているか状態を表示：その２_SQLite
-- ============================================================================================

SELECT center, CASE WHEN COUNT(material) <> COUNT(DISTINCT material) THEN 'ダブりあり'
                    ELSE 'ダブりなし' END
FROM Materials
GROUP BY center;

-- ==============================================================================================
-- 資材のダブっている拠点を選択する:EXISTSへの書き換え：その３_SQLite
-- ==============================================================================================

SELECT center, material
FROM Materials M1
WHERE EXISTS (SELECT *
                FROM Materials M2
                WHERE M1.center = M2.center 
                AND M1.material = M2.material 
                AND M1.receive_date <> M2.receive_date

);

-- ===============================================================================================
-- ビールと紙オムツと自転車をすべて置いている店舗を検索する_SQlite
-- ===============================================================================================

SELECT SI.shop
FROM ShopItems SI INNER JOIN Items I
ON SI.item = I.item 
GROUP BY SI.shop
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items);

-- ==============================================================================================
-- ビールと紙オムツと自転車しか置いていない店舗を検索する_SQLite
-- ==============================================================================================

SELECT SI.shop
FROM ShopItems SI LEFT OUTER JOIN Items I
ON SI.item = I.item
GROUP BY SI.shop
HAVING COUNT(SI.item) = (SELECT COUNT(item) FROM Items)
AND COUNT(I.Item) = (SELECT COUNT(item) FROM Items);
