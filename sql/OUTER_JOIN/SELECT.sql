-- =================================================
-- 完全外部結合で情報を補完
-- =================================================

SELECT COALESCE(A.id,B.id) AS id,
        A.name AS A_name,
        B.name AS B_name
FROM Class_A A FULL OUTER JOIN Class_B B
ON A.id = B.id;

-- ================================================
-- 外部結合で行列変換
-- ================================================

SELECT C0.name, 
CASE WHEN C1.name IS NOT NULL THEN '〇' ELSE NULL END AS "SQL入門",
CASE WHEN C2.name IS NOT NULL THEN '〇' ELSE NULL END AS "UNIX入門",
CASE WHEN C3.name IS NOT NULL THEN '〇' ELSE NULL END AS "Java入門"
FROM (SELECT DISTINCT name FROM Courses) C0
LEFT OUTER JOIN (SELECT name FROM Courses WHERE courses = 'SQL入門') C1
ON C0.name = C1.name
LEFT OUTER JOIN (SELECT name FROM Courses WHERE courses = 'UNIX基礎') C2
ON C0.name = C2.name
LEFT OUTER JOIN (SELECT name FROM Courses WHERE courses ='Java基礎') C3
ON C0.name = C3.name;

-- =====================================================
-- スカラサブクエリで行列変換
-- =====================================================

SELECT C0.name,
        (SELECT '〇'
        FROM Courses C1
        WHERE courses ='SQL入門' 
        AND C1.name = C0.name
        ) AS "SQL入門",
        (SELECT '〇'
        FROM Courses C2
        WHERE courses = 'UNIX基礎'
        AND C2.name = C0.name
        ) AS 'UINIX基礎',
        (SELECT '〇'
        FROM Courses C3
        WHERE courses = 'Java基礎'
        AND C3.name = C0.name) 
        AS "Java基礎"
FROM (SELECT DISTINCT name FROM Courses) C0;

-- ==========================================================
-- CASE式を入れ子にして行列変換
-- ==========================================================

SELECT name,
CASE WHEN SUM(CASE WHEN courses = 'SQL入門' THEN 1 END) = 1 THEN '〇' END AS 'SQL入門',
CASE WHEN SUM(CASE WHEN courses = 'UNIX基礎' THEN 1 END) = 1 THEN '〇' END AS 'UNIX基礎',
CASE WHEN SUM(CASE WHEN courses = 'Java基礎' THEN 1 END) = 1 THEN '〇' END AS 'Java基礎'
FROM Courses
GROUP BY name;

-- ==========================================================
-- 列から行に変換　その１
-- ==========================================================

SELECT enployee, child_1 AS child FROM Personnel

UNION ALL

SELECT enployee, child_2 AS child FROM Personnel

UNION ALL

SELECT enployee, child_3 AS child FROM Personnel;

-- ==========================================================
-- 列から行に変換　その２
-- ==========================================================

CREATE VIEW Children(child) 

AS SELECT child_1 AS child FROM Personnel

UNION

SELECT child_2 AS child FROM Personnel

UNION

SELECT child_3 AS child FROM Personnel;


SELECT EMP.enployee, Children.child
FROM Personnel EMP 
LEFT OUTER JOIN Children
ON Children.child IN (EMP.child_1, EMP.child_2, EMP.child_3);