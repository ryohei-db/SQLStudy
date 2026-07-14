-- =================================================
-- テーブルに存在しないデータを探す
-- =================================================

INSERT INTO Meetings VALUES ('第1回','伊藤');
INSERT INTO Meetings VALUES ('第1回','水島');
INSERT INTO Meetings VALUES ('第1回','坂東');
INSERT INTO Meetings VALUES ('第2回','伊藤');
INSERT INTO Meetings VALUES ('第2回','宮田');
INSERT INTO Meetings VALUES ('第3回','坂東');
INSERT INTO Meetings VALUES ('第3回','水島');
INSERT INTO Meetings VALUES ('第3回','宮田');


-- ==================================================
-- 二重否定への変換に慣れよう
-- =================================================

INSERT INTO TestScore VALUES ('100', '算数', 100);
INSERT INTO TestScore VALUES ('100', '国語', 80);
INSERT INTO TestScore VALUES ('100', '理科', 80);
INSERT INTO TestScore VALUES ('200', '算数', 80);
INSERT INTO TestScore VALUES ('200', '国語', 95);
INSERT INTO TestScore VALUES ('300', '算数', 40);
INSERT INTO TestScore VALUES ('300', '国語', 90);
INSERT INTO TestScore VALUES ('300', '社会', 55);
INSERT INTO TestScore VALUES ('400', '算数', 80);

-- ===============================================
-- init_sql テスト 引数あり
--================================================

INSERT INTO init_reset_test VALUES ('1');

-- ===============================================
-- init_sql テスト 引数なし対話
--================================================

INSERT INTO init_reset_test2 VALUES ('2');

-- ===============================================
-- init_sql テスト ダミー
--================================================

INSERT INTO init_reset_test3 VALUES ('3');
