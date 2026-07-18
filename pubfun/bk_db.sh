#!/bin/bash

# bk_db() DBのバックアップの中身
# 初期実装では else を用いて正常処理をネストしていたが、可読性向上のため Early Exit を採用し、異常系のみを if で処理する構成へリファクタリングした。

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DB=""${BASE_DIR}"/db/study.db"

BACKUP_DIR=""${BASE_DIR}"/db_backup"



if [ ! "${DB}" -f ]; then

    echo ""${DB}"が存在しません"

    exit 1

fi

echo ""${DB}"が存在します"


if[ ! "${BACKUP_DIR}" -d ]; then

    echo ""${BACKUP_DIR}"が存在しません"

    mkdir -p "${BACKUP_DIR}"

fi














