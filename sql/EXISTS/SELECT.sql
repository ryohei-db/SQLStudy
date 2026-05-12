-- =================================================
-- テーブルに存在しないデータを探す
-- =================================================

SELECT  DISTINCT M1.meeting, M2.person
FROM Meetings M1 CROSS JOIN Meetings M2
WHERE NOT EXISTS (SELECT *
                FROM Meetings M3
                WHERE M1.meeting = M3.meeting
                AND M2.person = M3.person

 );

-- ===============================================
-- 二重変換への変換に慣れよう　その１
-- ===============================================

SELECT DISTINCT studnt_id
FROM TestScore T1
WHERE NOT EXISTS (
    
    SELECT *
    FROM TestScore T2
    WHERE T1.studnt_id = T2.studnt_id
    AND T2.score < 50
);


-- ==================================================
-- 二重変換への変換に慣れよう　その１
-- ==================================================

SELECT DISTINCT T1.studnt_id
FROM TestScore T1
WHERE NOT EXISTS (
    SELECT *
    FROM TestScore T2
    WHERE T1.studnt_id = T2.studnt_id
    AND 1 = CASE WHEN T2.subject = '算数' AND T2.score < 50 THEN 1
                WHEN T2.subject = '国語' AND T2.score < 80 THEN 1
                ELSE 0 END
);
