
# init_sql() : テーブル作成関数の中身

#!/bin/bash

# フォルダ名・テーブル名  の指定がなければ、入力を受け付けて入力を促す あれば　それぞれの値を$1/$2として　変数に代入する

 if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "フォルダ名 ファイル名 を入力してください : 入力待ち...."
    read folder table_name
    echo "フォルダ名:"${folder}" テーブル名:"${table_name}" : 入力済み"

else
    echo "フォルダ名 ファイル名 が すべて正しく入力されています"
    folder="${1}"
    table_name="${2}"
    echo "フォルダ名:"${folder}" テーブル名:"${table_name}" : 入力済み"
fi

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
    echo ""${folder}"/CREATE.sql が存在しません: ${create_file}"
    exit 1
fi

#フォルダにINSERTがない場合、"INSERT.sql が存在しません: ${insert_file}"　と表示して　終了

if [ ! -f "${insert_file}" ]; then
    echo ""${folder}"/INSERT.sql が存在しません: ${insert_file}"
    exit 1
fi

#DBにsqlite3を下記のSQLを実行してデータがあれば、"テーブル [${table_name}] は存在するので → 何もしない"と表示
#データがなければ、"初回 → CREATE & INSERT"　と表示して　"${create_file}"　"${insert_file}"　を実行

if sqlite3 "${DB}" "SELECT name FROM sqlite_master WHERE type = 'table' AND name = '${table_name}';" | grep -q .; then
    
    echo "テーブル ["${table_name}"] は存在するので → 何もしない"

else
    
    echo "初回 → CREATE & INSERT"
    
    sqlite3 "${DB}" < "${create_file}"
    
    if [ $? = 0 ]; then 

        echo ""${create_file}":CREATE.sql の実行に成功しました"
    
    else

        echo ""${create_file}":CREATE.sql の実行に失敗しました"

        exit 1
    
    fi

    sqlite3 "${DB}" < "${insert_file}"


    #　7/10ここから終了ステータスの処理の続き書く


fi