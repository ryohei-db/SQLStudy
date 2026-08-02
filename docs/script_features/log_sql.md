# log_sql.sh

## 概要

SQL実行処理を共通化するためのスクリプト。

各スクリプトから直接 `sqlite3` を実行せず、
`log_sql.sh` を経由してSQLを実行する。

---

# 処理の流れ

```text
呼び出し元スクリプト
        │
        ├─ SQLファイル または SQL文字列を渡す
        ▼
log_sql.sh
        │
        ├─ 共通設定(settings.conf)の読み込み
        ├─ ログファイル名を生成
        ├─ SQL実行開始時刻を取得
        ├─ SQL実行方法を判定
        │      ├─ SQLファイル
        │      └─ 標準入力(パイプ)
        ├─ sqlite3 を実行
        ├─ SQL実行結果(SUCCESS / FAILED)をログへ記録
        └─ 終了
```

---

# 入力

## SQLファイル

```bash
bash log_sql.sh "sql/EXISTS/CREATE.sql"
```

## SQL文字列

```bash
printf '%s\n' "${SQL}" |
bash log_sql.sh "CREATE:sample"
```

---

# 出力

- SQL実行結果
- SQL実行ログ

---

# 主な役割

- 共通設定(settings.conf)の読み込み
- SQLファイル・標準入力の判定
- sqlite3 の実行
- 実行開始時刻の取得
- SQL実行ログの記録

---

# メリット

- SQL実行方法を共通化できる
- SQL実行ログを一元管理できる
- sqlite3 の呼び出しを1か所へ集約できる
- 各スクリプトはSQL実行処理を書かず、本来の処理に集中できる
- 保守性・再利用性を向上できる