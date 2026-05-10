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