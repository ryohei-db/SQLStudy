#　reset_table() : テーブル削除関数の中身

# bashで実行するという指示　これは絶対つける

#!bin/bash

# テーブル名を指定しなければ、使い方を表示してエラーで終了

if [ -z "${1}"]; then
    echo "使い方：reset_table 引数（テーブル名）"
    exit 1

fi

# 入力値 : テーブル名の変数
# 入力値を受け付ける場合、入力値があることを確認してから変数を利用したいのでこの順序でいい

table_name="$1"

# 現在の格納場所から基準となるSQLStudyまでの絶対パス
# DBまでの絶対パス

BASE_DIR="$(cd "$(dirname "${BASHSOURCE[0]}")/.." && pwd)"
DB="${BASE_DIR}"/db/study.db

#　入力されたテーブル名が　sqlite_master にあるか調べるチェック値

table_check="$(sqlite3 "${DB}" "SELECT '存在します' FROM sqlite_master WHERE tbl_name = '${table_name}';")"

# チェック値の結果を表示

echo "${table_check}"

# 入力されたテーブル名があれば　存在する　なければ存在していないと表示し　エラーで終了させる

if [ "${table_check}" = "存在します" ]; then

    echo "テーブルは存在します"

else 

    echo "テーブルが存在していません！！ resetを実行できません"
    exit 1
fi









