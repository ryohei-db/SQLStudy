#!/bin/bash

# bk_db() DBのバックアップの中身
# 初期実装では else を用いて正常処理をネストしていたが、可読性向上のため Early Exit を採用し、異常系のみを if で処理する構成へリファクタリングした。

# スクリプトの基準ディレクトリを取得

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# データベースとバックアップ先のパス

DB=""${BASE_DIR}"/db/study.db"

BACKUP_DIR=""${BASE_DIR}"/db_backup"


# データベースの存在確認

if [ ! -f "${DB}" ]; then

    echo ""${DB}"が存在しません"

    exit 1

fi

echo ""${DB}"が存在します"

# バックアップディレクトリがなければ作成

if [ ! -d "${BACKUP_DIR}"  ]; then

    echo ""${BACKUP_DIR}"が存在しません"

    mkdir -p "${BACKUP_DIR}"

fi

# バックアップファイル名を作成

BACKUP_NAME="study_"$(date '+%Y%m%d%H%M%S')".db"

# データベースをバックアップ

cp "${DB}" "${BACKUP_DIR}"/"${BACKUP_NAME}"

# バックアップ成功確認

if [ $? -ne 0 ]; then

echo "バックアップファイルの作成に失敗しました"

exit 1

fi

# db_backup にある　ファイルで　30よりも前に作成されたファイルを見つけたら削除

find "${BACKUP_DIR}" -type f -name 'study_*.db' -mtime +30 -delete

# 最新のバックアップファイル30件を残し、31件目以降は削除する

ls -t "${BACKUP_DIR}" | tail -n +31 | xargs rm






















