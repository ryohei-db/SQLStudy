
#テーブル作成関数の中身

#!/bin/bash

#テーブル・フォルダ名がないなら使い方を表示　使い方：init_sql フォルダ名 テーブル名

 if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "使い方：init_sql フォルダ名 テーブル名"
    exit 1
fi

#指定する　フォルダとファイル　を意味する変数

folder="${1}"
table_name="${2}"

# gsave.sh の場所（pubfun/git）から2つ上へ移動
# SQLStudy を BASE_DIR とする

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 共通DBのパス
DB="$BASE_DIR/db/study.db"

#各フォルダにあるCREATE・INSERTファイルを定義した変数

create_file="${BASE_DIR}/sql/${folder}/CREATE.sql"
insert_file="${BASE_DIR}/sql/${folder}/INSERT.sql"

#フォルダにCREATEがない場合、"CREATE.sql が存在しません: ${create_file}"　と表示して　終了

if [ ! -f "${create_file}" ]; then
    echo "CREATE.sql が存在しません: ${create_file}"
    exit 1
fi

#フォルダにINSERTがない場合、"INSERT.sql が存在しません: ${insert_file}"　と表示して　終了

if [ ! -f "${insert_file}" ]; then
    echo "INSERT.sql が存在しません: ${insert_file}"
    exit 1
fi

#DBにsqlite3を下記のSQLを実行してデータがあれば、"テーブル [${table_name}] は存在するので → 何もしない"と表示
#データがなければ、"初回 → CREATE & INSERT"　と表示して　"${create_file}"　"${insert_file}"　を実行

if sqlite3 "${DB}" "SELECT name FROM sqlite_master WHERE type = 'table' AND name = '${table_name}';" | grep -q .; then
    echo "テーブル [${table_name}] は存在するので → 何もしない"
else
    echo "初回 → CREATE & INSERT"
    sqlite3 "${DB}" < "${create_file}"
    sqlite3 "${DB}" < "${insert_file}"
fi