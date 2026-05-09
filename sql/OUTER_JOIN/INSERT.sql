-- ==================================================
-- 完全外部結合で情報補完
-- ==================================================

INSERT INTO Class_A VALUES (1,'田中');
INSERT INTO Class_A VALUES (2,'鈴木');
INSERT INTO Class_A VALUES (3,'伊集院');

INSERT INTO Class_B VALUES (1,'田中');
INSERT INTO Class_B VALUES (2,'鈴木');
INSERT INTO Class_B VALUES (4,'西園寺');


-- =================================================
-- 外部結合で行列変換
-- =================================================

INSERT INTO Courses VALUES ('赤井','SQL入門');
INSERT INTO Courses VALUES ('赤井','UNIX基礎');
INSERT INTO Courses VALUES ('鈴木','SQL入門');
INSERT INTO Courses VALUES ('工藤','SQL入門');
INSERT INTO Courses VALUES ('工藤','Java入門');
INSERT INTO Courses VALUES ('吉田','UNIX基礎');
INSERT INTO Courses VALUES ('渡辺','SQL入門');


-- ==============================================
-- 列から行に変換
-- ==============================================

INSERT INTO Personnel VALUES ('赤井','一郎','二郎','三郎');
INSERT INTO Personnel VALUES ('工藤','春子','夏子',NULL);
INSERT INTO Personnel VALUES ('鈴木','夏子',NULL,NULL);
INSERT INTO Personnel VALUES ('吉田',NULL,NULL,NULL);



