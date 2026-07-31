#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/settings.conf"

# bk_db() DBのバックアップの中身
# 初期実装では else を用いて正常処理をネストしていたが、可読性向上のため Early Exit を採用し、異常系のみを if で処理する構成へリファクタリングした。


# データベースの存在確認

if [ ! -f "${DB}" ]; then

    echo "${DB}が存在しません" >&2

    exit 1

fi

echo "${DB}が存在します"

# バックアップディレクトリがなければ作成

if [ ! -d "${BACKUP_DIR}"  ]; then

    echo "${BACKUP_DIR}が存在しません!! ディレクトリを作成します"

    mkdir -p "${BACKUP_DIR}"

fi

# バックアップファイル名を作成

BACKUP_NAME="study_$(date '+%Y-%m-%d %H:%M:%S').db"

# データベースをバックアップ

if ! cp "${DB}" "${BACKUP_DIR}"/"${BACKUP_NAME}"; then

    echo "バックアップファイルの作成に失敗しました" >&2

    exit 1

fi

# db_backup にある　ファイルで　30よりも前に作成されたファイルを見つけたら削除

find "${BACKUP_DIR}" -type f -name 'study_*.db' -mtime +30 -delete

# 最新のバックアップファイル30件を残し、31件目以降は削除する
# shellcheck disable=SC2012
# バックアップファイル名はスクリプトで生成しており、空白・特殊文字を含まないため ls を使用する。

ls -t "${BACKUP_DIR}" | tail -n +31 | xargs rm
























