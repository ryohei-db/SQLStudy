#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

cron_targets="${BASE_DIR}/cron/cron_targets.conf"

if [ ! -f "${cron_targets}" ]; then

    echo "cron対象リストが存在しません" >&2
    exit 1
fi

while read -r target_file; do 

    find "${BASE_DIR}" -type f -name "${target_file}"

done < "${cron_targets}"

