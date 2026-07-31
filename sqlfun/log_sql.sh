#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/settings.conf"

# shellcheck disable=SC2034
start_datetime="$(date '+%Y-%m-%d %H:%M:%S')"


if [ -t 0 ]; then
    # 標準入力なし → SQLファイルを使う
    sql_file="$1"
    sqlite3 "${DB}" < "${sql_file}"
else
    # 標準入力あり → パイプから受け取る
    sqlite3 "${DB}"
fi