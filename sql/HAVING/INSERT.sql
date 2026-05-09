-- =================================
-- データ投入_データの歯抜けを探す
-- =================================

INSERT INTO SeqTbl VALUES (1,'ディック');
INSERT INTO SeqTbl VALUES (2,'アン');
INSERT INTO SeqTbl VALUES (3,'ライル');
INSERT INTO SeqTbl VALUES (5,'カー');
INSERT INTO SeqTbl VALUES (6,'マリー');
INSERT INTO SeqTbl VALUES (8,'ベン');

-- =====================================
-- 最頻値を求める
-- =====================================

INSERT INTO Graduates VALUES ('サンプソン',400000);
INSERT INTO Graduates VALUES ('ホワイト',20000);
INSERT INTO Graduates VALUES ('アーノルド',20000);
INSERT INTO Graduates VALUES ('スミス',20000);
INSERT INTO Graduates VALUES ('ロレンス',15000);
INSERT INTO Graduates VALUES ('ハドソン',15000);
INSERT INTO Graduates VALUES ('ケント',10000);
INSERT INTO Graduates VALUES ('ベッカー',10000);
INSERT INTO Graduates VALUES ('スコット',10000);

-- ========================================
-- NULLを含まない集合を探す
-- ========================================

INSERT INTO Students VALUES (100,'理学部','2018-10-10');
INSERT INTO Students VALUES (101,'理学部','2018-09-22');
INSERT INTO Students VALUES (102,'文学部',NULL);
INSERT INTO Students VALUES (103,'文学部','2018-09-10');
INSERT INTO Students VALUES (200,'文学部','2018-09-22');
INSERT INTO Students VALUES (201,'工学部',NULL);
INSERT INTO Students VALUES (202,'経済学部','2018-09-25');


-- =============================================
-- 特性関数の応用
-- =============================================

INSERT INTO TestResult VALUES (01,'A','男',100);
INSERT INTO TestResult VALUES (02,'A','女',100);
INSERT INTO TestResult VALUES (03,'A','女',49);
INSERT INTO TestResult VALUES (04,'B','男',30);
INSERT INTO TestResult VALUES (05,'B','女',100);
INSERT INTO TestResult VALUES (06,'B','男',92);
INSERT INTO TestResult VALUES (07,'B','男',80);
INSERT INTO TestResult VALUES (08,'B','男',80);
INSERT INTO TestResult VALUES (09,'B','女',10);
INSERT INTO TestResult VALUES (10,'C','男',92);
INSERT INTO TestResult VALUES (11,'C','男',80);
INSERT INTO TestResult VALUES (12,'C','女',21);
INSERT INTO TestResult VALUES (13,'D','女',100);
INSERT INTO TestResult VALUES (14,'D','女',0);
INSERT INTO TestResult VALUES (15,'D','女',0);


-- =================================================
-- HAVING句の全称量化
-- =================================================

INSERT INTO Teams VALUES('ジョー',1,'待機');
INSERT INTO Teams VALUES('ケン',1,'出勤中');
INSERT INTO Teams VALUES('ミック',1,'待機');
INSERT INTO Teams VALUES('カレン',2,'出勤中');
INSERT INTO Teams VALUES('キース',2,'休暇');
INSERT INTO Teams VALUES('ジャン',3,'待機');
INSERT INTO Teams VALUES('ハート',3,'待機');
INSERT INTO Teams VALUES('ディック',3,'待機');
INSERT INTO Teams VALUES('ベス',4,'待機');
INSERT INTO Teams VALUES('アレン',5,'出勤中');
INSERT INTO Teams VALUES('ロバート',5,'休暇');
INSERT INTO Teams VALUES('ケーガン',5,'待機');



-- =====================================================
-- 一意集合と多重集合
-- =====================================================

INSERT INTO Materials VALUES('東京','2018-4-01','錫');
INSERT INTO Materials VALUES('東京','2018-4-12','亜鉛');
INSERT INTO Materials VALUES('東京','2018-5-17','アルミニウム');
INSERT INTO Materials VALUES('東京','2018-5-17','亜鉛');
INSERT INTO Materials VALUES('大阪','2018-4-20','銅');
INSERT INTO Materials VALUES('大阪','2018-4-22','ニッケル');
INSERT INTO Materials VALUES('大阪','2018-4-29','鉛');
INSERT INTO Materials VALUES('名古屋','2018-3-15','チタン');
INSERT INTO Materials VALUES('名古屋','2018-4-01','炭素鋼');
INSERT INTO Materials VALUES('名古屋','2018-4-24','炭素鋼');
INSERT INTO Materials VALUES('名古屋','2018-5-02','マグネシウム');
INSERT INTO Materials VALUES('名古屋','2018-5-10','チタン');
INSERT INTO Materials VALUES('福岡','2018-5-10','亜鉛');
INSERT INTO Materials VALUES('福岡','2018-5-28','錫');


-- ========================================================
-- 関係除算とバスケット関数
-- ========================================================

INSERT INTO ShopItems VALUES ('仙台','ビール');
INSERT INTO ShopItems VALUES ('仙台','紙オムツ');
INSERT INTO ShopItems VALUES ('仙台','自転車');
INSERT INTO ShopItems VALUES ('仙台','カーテン');
INSERT INTO ShopItems VALUES ('東京','ビール');
INSERT INTO ShopItems VALUES ('東京','紙オムツ');
INSERT INTO ShopItems VALUES ('東京','自転車');
INSERT INTO ShopItems VALUES ('大阪','テレビ');
INSERT INTO ShopItems VALUES ('大阪','紙オムツ');
INSERT INTO ShopItems VALUES ('大阪','自転車');

INSERT INTO Items VALUES ('自転車');
INSERT INTO Items VALUES ('紙オムツ');
INSERT INTO Items VALUES ('ビール');