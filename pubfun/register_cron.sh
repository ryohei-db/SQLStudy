#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"

# cron定期実行対象リストの設定

cron_targets_lists="${BASE_DIR}/cron/cron_targets.conf"

# cron定期実行対象リストの存在確認

if [ ! -f "${cron_targets_lists}" ]; then

    echo "cron対象リストが存在しません" >&2
    exit 1
fi

# cron対象ファイルを1件ずつ検索・確認

if ! cron_targets="$(while read -r target_file; do 

     # 対象ファイルを検索し、絶対パスを取得

    targets_path="$(find "${BASE_DIR}" -type f -name "${target_file}")"
    
     # 対象ファイルが0件の場合はエラー

    if [ -z "${targets_path}" ]; then
        
        echo "エラー：${target_file} が見つかりません" >&2

        exit 1
    fi

     # 検索結果の件数を取得

    count_targets="$(printf '%s\n' "${targets_path}" | wc -l)"

     # 同名ファイルが複数存在する場合はエラー

    if [ "${count_targets}" -gt 1 ]; then

        echo "エラー：${target_file} が ${count_targets} 件見つかりました" >&2

        exit 1
    
    else

         # 正常に見つかったファイルの絶対パスを出力

        printf '%s\n' "${targets_path}"

    fi


done < "${cron_targets_lists}")"; then

    exit 1
fi

# 対象ファイルの絶対パスからSQLStudyまでのパスを取得

if ! cron_targets_BASE_DIR_ps="$(

    printf '%s\n' "${cron_targets}" |

     awk -F'/' '{

         # パス生成用の変数を初期化
        path = ""

         # パスを先頭から1項目ずつ確認
        for (i = 2; i <= NF; i++) {
            
             # 現在の項目をpathへ追加
            path = path "/" $i

            # SQLStudyまで到達したらパスを出力して終了
            if ($i == "SQLStudy") {
                print path
                exit
            }
        }
    }'
)"; then

    exit 1

fi

# cronテンプレートのBASE_DIRを実環境のパスへ置換

if ! cron_record="$(
    sed "s|\${BASE_DIR}|${cron_targets_BASE_DIR_ps}|g" \
        "${BASE_DIR}/cron/db_bk.cron"
)"; then

    exit 1

fi

# 生成したcron設定を表示

printf '%s\n' "${cron_record}"

# cron登録の実行確認

read -r -p "この内容でcronを登録しますか？ y/n : " answer

# yの場合のみcrontabへ登録


if [ "${answer}" = "y" ]; then
    printf '%s\n' "${cron_record}" | crontab -
else
    echo "cron登録を中止しました"
fi

# 登録後のcrontabを確認

crontab -l















