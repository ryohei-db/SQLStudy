#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

# ログファイルの作成日
log_date="$(date '+%Y_%m_%d')"

# ログファイルのパス
log_file="${LOG_DIR}/${SHELL_LOG_PREFIX}_${log_date}.log"

# ログ開始時刻
start_date="$(date '+%Y_%m_%d %H:%M:%S' )"

# 第1引数から実行対象のシェルスクリプトを取得する
shell_target="$1"

# 実行対象を引数一覧から除外して
# 残りの引数を対象スクリプトへ渡せる状態にする
shift

# 対象スクリプトを実行する
# 実行に失敗した場合は FAILED をログへ記録して終了する
if ! bash "${shell_target}" "$@"; then

    printf '%s\n' \
    "${start_date} | ${shell_target} | FAILED" \
    >> "${log_file}"

    exit 1
fi

# 実行成功時は SUCCESS をログへ記録して正常終了する
printf '%s\n' \
"${start_date} | ${shell_target} | SUCCESS" \
>> "${log_file}"

exit 0



