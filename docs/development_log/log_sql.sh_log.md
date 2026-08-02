# log_sql() 開発記録

### 1. SQL実行処理の共通化

各スクリプトで直接 `sqlite3` を実行していた処理を見直し、
SQL実行を `log_sql.sh` に集約する方針へ変更した。

変更前

```text
init_sql.sh
    └─ sqlite3

reset_table.sh
    └─ sqlite3
```

変更後

```text
init_sql.sh
        │
reset_table.sh
        │
select_file.sh
        │
        ▼
    log_sql.sh
        │
        ▼
     sqlite3
```

これにより、SQL実行方法を共通化し、今後のログ取得や保守を容易にできる構成へ変更した。

---

### 2. SQL入力方法の統一

`log_sql.sh` は以下2種類の入力に対応する設計とした。

- SQLファイル
- パイプによるSQL文字列

SQLファイル

```bash
bash log_sql.sh "sql/EXISTS/CREATE.sql"
```

SQL文字列

```bash
printf '%s\n' "${SQL}" |
bash log_sql.sh "CREATE:employee"
```

---

### 3. 実行方法の判定

標準入力の有無を判定し、実行方法を切り替える。

```bash
if [ -t 0 ]; then
```

- 標準入力なし → SQLファイル実行
- 標準入力あり → パイプから受け取ったSQLを実行

---

### 4. ログ出力機能を追加

SQL実行結果をログファイルへ保存する仕組みを追加した。

ログファイルは

```text
${LOG_DIR}/${SQL_LOG_PREFIX}_YYYY_MM_DD.log
```

形式で生成する。

ログ内容

```text
2026-08-03 00:10:15 | CREATE:employee | SUCCESS
2026-08-03 00:11:20 | INSERT:employee | FAILED
```

---

### 5. 共通設定を利用

`settings.conf` を読み込み、

- DB
- LOG_DIR
- SQL_LOG_PREFIX

などの共通設定を利用する構成へ変更した。

---

### 6. 設計方針の整理

今回の実装では以下の設計方針を採用した。

- SQL実行処理は `log_sql.sh` に集約する
- 各スクリプトは SQL を直接実行しない
- SQLファイル・SQL文字列の両方へ対応する
- SQL実行結果を共通ログへ記録する
- 共通設定は `settings.conf` で管理する

---

## 今後の予定

- 実行終了時刻の取得
- 実行時間の計算
- ログ出力内容の拡充
- Shellログ(`write_shell_log.sh`)への展開
