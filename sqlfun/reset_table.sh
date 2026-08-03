#!/bin/bash

set -o pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

#　reset_table() : テーブル削除関数の中身


# テーブル名が引数で指定されていない場合は入力待ちで入力を促す
# 指定されている場合は第1引数($1)をテーブル名として使用する

if [ -z "${1}" ]; then
    echo "テーブル名を入力してください : ......入力待ち"
    read -r table_name

    
    if [ -z "${table_name}" ]; then

        echo "入力値が空のままです" >&2
        
        exit 1
    fi

    echo "テーブル名:${table_name} : 入力済み"

else

    echo "テーブル名が 正しく入力されています"
    table_name="${1}"
    echo "テーブル名:${table_name} : 入力済み"
fi


# 入力されたテーブル名を基に sqlite_master を検索し、
# テーブルが存在する場合は削除確認へ進み、存在しない場合はエラーで終了する
# y: DROP TABLEを実行 | n: 何もせず正常終了 | それ以外: 入力エラーで終了
# yを選択した場合は、削除結果を終了ステータスで判定する
# 削除成功時はメッセージを表示して正常終了し、失敗時はエラーで終了する


if printf '%s\n' \
    "SELECT tbl_name FROM sqlite_master WHERE type = 'table' AND tbl_name = '${table_name}';" |
    bash "${BASE_DIR}/sqlfun/log_sql.sh" "テーブル存在確認:${table_name}" |
    grep -q .; then

    echo "${table_name}テーブルは存在します"
    echo "resetを実行しますか？ : 実行する > y | 実行しない > n"

    read -r reset_exec

    if [ "${reset_exec}" = "y" ]; then

        if ! printf '%s\n' "DROP TABLE IF EXISTS ${table_name};" |
            bash "${BASE_DIR}/sqlfun/log_sql.sh" "DROP:${table_name}"; then

            echo "テーブル:${table_name}の削除に失敗しました" >&2
            exit 1

        fi

        echo "テーブル:${table_name}を削除しました"
        exit 0

        
    elif [ "${reset_exec}" = "n" ]; then

        echo "テーブルの削除を中止しました"
        exit 0

    else

        echo "y または n を入力してください" >&2

        exit 1

    fi

else
    echo "${table_name}テーブルは存在しません。resetを実行できません" >&2
    exit 1
fi
    












