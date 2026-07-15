#!/bin/bash

# select_file() の中身

# 現時点:2026/07/16時点では実行ファイルはSQLファイルのみ　＊必要になれば各拡張子ごとのファイルの実行方法を追加　

# $1(folder)にはBASE_DIR から見た格納フォルダパスを入力する

if [ -z "$1" ] || [ -z "$2" ]; then

    echo "入力方式 : 格納フォルダ名(二つ以上離れてたら相対パスで sql/EXISTSのようにして指定） ファイル名（拡張子が必要） 引数を入力してください.....入力待ち"

    read folder file_nm

else

    echo "格納フォルダ名 ファイル名 が正常に入力されいます"
    
    folder="$1"
    file_nm="$2"

    echo "格納フォルダ名 :"${folder}" 格納フォルダ名 : "${file_nm}" が入力されています"
    

fi

# select_file.sh の格納場所から1つ上へ移動
# SQLStudy を BASE_DIR とする

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 共通DBのパス

DB=""${BASE_DIR}"/db/study.db"


# 対象のファイルパス.sql

tar_sql_ps=""${BASE_DIR}"/"${folder}"/"${file_nm}""























