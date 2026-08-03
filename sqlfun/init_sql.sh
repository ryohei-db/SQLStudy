#!/bin/bash

set -o pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

# init_sql() : テーブル作成処理

# フォルダ名・テーブル名の指定がなければ入力を受け付ける
if [ -z "${1}" ] || [ -z "${2}" ]; then

    echo "フォルダ名 テーブル名 を入力してください : 入力待ち...."
    read -r folder table_name

    if [ -z "${folder}" ] || [ -z "${table_name}" ]; then

        echo "入力値が空のままです" >&2
        exit 1

    else

        echo "フォルダ名:${folder} テーブル名:${table_name} : 入力済み"

    fi

else

    echo "フォルダ名 テーブル名 がすべて正しく入力されています"

    folder="${1}"
    table_name="${2}"

    echo "フォルダ名:${folder} テーブル名:${table_name} : 入力済み"

fi


# 各フォルダにあるCREATE・INSERTファイル

create_file="${BASE_DIR}/sql/${folder}/CREATE.sql"
insert_file="${BASE_DIR}/sql/${folder}/INSERT.sql"


# CREATE.sql の存在確認

if [ ! -f "${create_file}" ]; then

    echo "${folder}/CREATE.sql が存在しません: ${create_file}" >&2
    exit 1

fi


# INSERT.sql の存在確認

if [ ! -f "${insert_file}" ]; then

    echo "${folder}/INSERT.sql が存在しません: ${insert_file}" >&2
    exit 1

fi


# 対象テーブルが存在する場合は正常終了する
# 存在しない場合はCREATE・INSERTを実行する

if printf '%s\n' \
    "SELECT name FROM sqlite_master WHERE type = 'table' AND name = '${table_name}';" |
    bash "${BASE_DIR}/sqlfun/log_sql.sh" "テーブル存在確認:${table_name}" |
    grep -q .; then

    echo "${table_name}テーブル は存在するのでそのまま終了します"
    exit 0

else

    echo "${table_name}テーブル は存在しないので新規テーブルの作成処理を開始します"
    echo "これから${create_file}内の${table_name} のCREATE文を実行します"

fi


# CREATE.sql から対象テーブルのCREATE文を抽出する

if ! cr_tab_sql="$(
    awk -v table="${table_name}" '

    $1 == "CREATE" && $2 == "TABLE" && $3 == table {

        flag = 1
        found = 1

    }

    flag {

        print

    }

    flag && /;/ {

        flag = 0

    }

    END {

        if (!found) {

            print "対象のテーブル:" table "のCREATE文が見つかりません" > "/dev/stderr"
            exit 1

        }

    }' "${create_file}"
)"; then

    echo "${table_name} のCREATE文の抽出に失敗しました" >&2
    exit 1

fi


echo "${table_name} のCREATE文を抽出できました"

echo "----- 抽出SQL確認 -----"
echo "${cr_tab_sql}"
echo "----------------------"


# CREATE文を実行する

if ! printf '%s\n' "${cr_tab_sql}" |
    bash "${BASE_DIR}/sqlfun/log_sql.sh" "CREATE:${table_name}"; then

    echo "${table_name}:CREATE文の実行に失敗しました" >&2
    exit 1

fi


echo "${table_name} のCREATE文の実行に成功しました"
echo "これから${insert_file}内の${table_name} のINSERT文を実行します"


# INSERT.sql から対象テーブルのINSERT文を抽出する

if ! in_tab_sql="$(
    awk -v table="${table_name}" '

    $1 == "INSERT" && $2 == "INTO" && $3 == table {

        flag = 1
        found = 1

    }

    flag {

        print

    }

    flag && /;/ {

        flag = 0

    }

    END {

        if (!found) {

            print "対象のテーブル:" table "のINSERT文が見つかりません" > "/dev/stderr"
            exit 1

        }

    }' "${insert_file}"
)"; then

    echo "${table_name} のINSERT文の抽出に失敗しました" >&2
    echo "${table_name} テーブルを削除します"

    if ! printf '%s\n' "DROP TABLE IF EXISTS ${table_name};" |
        bash "${BASE_DIR}/sqlfun/log_sql.sh" "DROP:${table_name}"; then

        echo "${table_name} テーブルの削除に失敗しました" >&2

    fi

    exit 1

fi


echo "${table_name} のINSERT文を抽出できました"

echo "----- 抽出SQL確認 -----"
echo "${in_tab_sql}"
echo "----------------------"


# INSERT文を実行する

if ! printf '%s\n' "${in_tab_sql}" |
    bash "${BASE_DIR}/sqlfun/log_sql.sh" "INSERT:${table_name}"; then

    echo "${table_name}:INSERT文の実行に失敗しました" >&2
    echo "${table_name} テーブルを削除します"

    if ! printf '%s\n' "DROP TABLE IF EXISTS ${table_name};" |
        bash "${BASE_DIR}/sqlfun/log_sql.sh" "DROP:${table_name}"; then

        echo "${table_name} テーブルの削除に失敗しました" >&2

    fi

    exit 1

fi


echo "${table_name} のINSERT文の実行に成功しました"
echo "${table_name}の作成が完了しました"

exit 0