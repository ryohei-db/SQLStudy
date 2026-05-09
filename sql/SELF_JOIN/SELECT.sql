==========================================
--組み合わせを得るSQL_正
==========================================
SELECT P1.name AS name_1, P2.name as name_2
FROM products P1 INNER JOIN products P2
ON P1.name > P2.name;


===========================================
--順序対を得るSQL_誤
===========================================
SELECT P1.name as name_1, P2.name as name_2
FROM products P1 INNER JOIN products P2
ON P1.name <> P2.name;


===============================================
--重複行を削除:極値関数
===============================================
DELETE FROM Products2 P1
WHERE rowid < (
    SELECT MAX(P2.rowid)
    FROM Products2 P2
    WHERE P1.name = P2.name
      AND P1.price = P2.price
);

===============================================
--重複行の削除:非等号値
===============================================
DELETE FROM Products2 P1
WHERE EXISTS (
    SELECT *
    FROM Products2 P2
    WHERE P1.name = P2.name
      AND P1.price = P2.price
      AND P1.rowid < P2.rowid
);