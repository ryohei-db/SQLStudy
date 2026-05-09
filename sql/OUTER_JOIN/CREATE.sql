-- =================================================
-- 完全外部結合で情報を補完
-- =================================================

CREATE TABLE Class_A (

    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE Class_B(

    id INTEGER PRIMARY KEY,
    name TEXT
);

-- =================================================
-- 外部結合で行列変換
-- =================================================

CREATE TABLE Courses (

    name TEXT,
    courses TEXT
);

-- ==================================================
-- 列から行に変換
-- ==================================================

CREATE TABLE Personnel (

    enployee TEXT,
    child_1 TEXT,
    child_2 TEXT,
    child_3 TEXT
);