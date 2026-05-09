-- =========================================
-- データ投入:順序対と組み合わせ
-- =========================================
INSERT INTO Products VALUES ('りんご',100);
INSERT INTO Products VALUES ('みかん',50);
INSERT INTO Products VALUES ('バナナ',80);

-- =========================================
-- データ投入：重複行の削除
-- ========================================

INSERT INTO Products2 VALUES ('りんご',100);
INSERT INTO Products2 VALUES ('みかん',50);
INSERT INTO Products2 VALUES ('みかん',50);
INSERT INTO Products2 VALUES ('みかん',50);
INSERT INTO Products2 VALUES ('バナナ',80);
