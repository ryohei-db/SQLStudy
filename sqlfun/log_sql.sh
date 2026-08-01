#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/settings.conf"


# shellcheck disable=SC2034
start_time="$(date '+%s')"

# shellcheck disable=SC2034
start_datetime="$(date '+%Y-%m-%d %H:%M:%S')"


if [ -t 0 ]; then

    sqlite_file="$1"

    if ! sqlite3 "${DB}" < "${sqlite_file}"; then

        echo "SQLの実行に失敗しました"
        exit 1
    fi

else

    if ! sqlite3 "${DB}"; then

        echo "SQLの実行に失敗しました"
        exit 1
    fi

fi

# shellcheck disable=SC2034
end_datetime="$(date '+%Y-%m-%d %H:%M:%S')"

# shellcheck disable=SC2034
end_time="$(date '+%s')"

# shellcheck disable=SC2034
elapsed_time="$(( end_time - start_time ))"

