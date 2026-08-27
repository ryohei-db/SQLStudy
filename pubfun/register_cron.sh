#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

cron_targets_lists="${BASE_DIR}/cron/cron_targets.conf"

if [ ! -f "${cron_targets_lists}" ]; then

    echo "cron対象リストが存在しません" >&2
    exit 1
fi

if ! cron_targets="$(while read -r target_file; do 

    targets_path="$(find "${BASE_DIR}" -type f -name "${target_file}")"
    
    if [ -z "${targets_path}" ]; then
        
        echo "エラー：${target_file} が見つかりません" >&2

        exit 1
    fi

    count_targets="$(printf '%s\n' "${targets_path}" | wc -l)"

    if [ "${count_targets}" -gt 1 ]; then

        
        echo "エラー：${target_file} が ${count_targets} 件見つかりました" >&2

        exit 1
    
    else

        printf '%s\n' "${targets_path}"

    fi


done < "${cron_targets_lists}")"; then

    exit 1
fi


if ! cron_targets_BASE_DIR_ps="$(

    printf '%s\n' "${cron_targets}" |

     awk -F'/' '{
        path = ""
        for (i = 2; i <= NF; i++) {
            path = path "/" $i
            if ($i == "SQLStudy") {
                print path
                exit
            }
        }
    }'
)"; then

    exit 1

fi

if ! cron_record="$(
    sed "s|\${BASE_DIR}|${cron_targets_BASE_DIR_ps}|g" \
        "${BASE_DIR}/cron/db_bk.cron"
)"; then

    exit 1

fi

printf '%s\n' "${cron_record}"

read -r -p "この内容でcronを登録しますか？ y/n : " answer

if [ "${answer}" = "y" ]; then
    printf '%s\n' "${cron_record}" | crontab -
else
    echo "cron登録を中止しました"
fi

crontab -l















