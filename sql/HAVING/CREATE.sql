-- ==================================
-- テーブル作成_データの歯抜けを探す
-- ==================================

CREATE TABLE SeqTbl (

    seq  INTEGER PRIMARY KEY,
    name TEXT

);

-- ==========================================
-- 最頻値を求める
-- ==========================================

CREATE TABLE Graduates (

    name TEXT PRIMARY KEY,
    income REAL
);

-- ===========================================
-- 提出日にNULLを含まない集合を探す
-- ===========================================

CREATE TABLE Students(

    id INTEGER PRIMARY KEY,
    dpt TEXT,
    sbmt_date TEXT
);

-- =============================================================
-- 特性関数の応用_SQLite
-- =============================================================

CREATE TABLE TestResult(

    id INTEGER  PRIMARY KEY,
    class TEXT,sex TEXT,score INTEGER
);

-- =============================================================
-- HAVING句で全称量化_SQLite
-- =============================================================

CREATE TABLE Teams (

    member TEXT PRIMARY KEY,
    team_id INTEGER,
    status TEXT
    
);

-- ================================================================
-- 一意集合と多重集合_SQLite
-- ================================================================

CREATE TABLE Materials (

    center TEXT,
    receive_date TEXT,
    material TEXT
);


-- =================================================================
-- 関係除算とバスケット関数_SQLite
-- =================================================================

CREATE TABLE ShopItems (

    shop TEXT,
    item TEXT
);

CREATE TABLE Items (

    item TEXT
);
