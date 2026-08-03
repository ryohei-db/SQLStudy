#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

# ログファイルの作成日
log_date="$(date '+%Y_%m_%d')"

# ログファイルのパス
log_file="${LOG_DIR}/${SQL_LOG_PREFIX}_${log_date}.log"

# ログ開始時刻
start_datetime="$(date '+%Y-%m-%d %H:%M:%S')"


# 呼び出し先のコマンドの第1引数で受け取った実行対象(SQLファイル名・SQL識別名)を保持する

sql_target="$1"

# 標準入力の有無を判定する
# 標準入力がない場合はSQLファイルを実行し、
# 標準入力がある場合はパイプで渡されたSQLを実行する

if [ -t 0 ]; then

    # SQLファイルを実行し、失敗時はFAILEDログを出力して終了する

    if ! sqlite3 "${DB}" < "${sql_target}"; then

        printf '%s\n' \
            "${start_datetime} | ${sql_target} | FAILED" \
            >> "${log_file}"

        exit 1
    fi

else

    # パイプで渡されたSQLを実行し、失敗時はFAILEDログを出力して終了する

    if ! sqlite3 "${DB}"; then

         printf '%s\n' \
            "${start_datetime} | ${sql_target} | FAILED" \
            >> "${log_file}"
       
        exit 1
    fi


fi

# SQLの実行成功時はSUCCESSログを出力する

printf '%s\n' \
"${start_datetime} | ${sql_target} | SUCCESS" \
>> "${log_file}"

exit 0

