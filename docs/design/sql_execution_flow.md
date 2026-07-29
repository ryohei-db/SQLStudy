# SQL実行方法の変更

## 概要

SQL実行処理を共通化するため、各スクリプトから `sqlite3` を直接実行する方式を廃止し、
`log_sql.sh` を経由してSQLを実行する構成へ変更した。

これにより、SQL実行・実行結果の記録・ログ出力を1か所へ集約した。

---

## 変更前

各スクリプトがそれぞれ `sqlite3` を直接実行していた。

```text
init_sql.sh
        │
        ├── sqlite3
        │
        └── 実行結果判定

reset_table.sh
        │
        ├── sqlite3
        │
        └── 実行結果判定

select_file.sh
        │
        ├── sqlite3
        │
        └── 実行結果判定
```

各スクリプトごとにSQL実行処理を持つため、修正箇所が分散していた。

---

## 変更後

SQL実行はすべて `log_sql.sh` を経由する。

```text
各スクリプト
        │
        ▼
log_sql.sh
        │
        ├── sqlite3実行
        ├── 実行時間計測
        ├── 実行結果判定
        └── ログ出力
```

---

## 呼び出し方法

SQLファイルを実行する場合

```bash
bash "${BASE_DIR}/sqlfun/log_sql.sh" "${SQL_FILE}"
```

SQL文字列を実行する場合

```bash
printf '%s\n' "${SQL}" |
bash "${BASE_DIR}/sqlfun/log_sql.sh" "CREATE:${table_name}"
```

---

## 主な変更対象

- init_sql.sh
- reset_table.sh
- select_file.sh

これらのスクリプトから直接 `sqlite3` を実行する処理を削除した。

---

## log_sql.sh の役割

- 共通DB設定の読み込み
- sqlite3 の実行
- SQL実行時間の計測
- 実行結果の取得
- SQL実行ログの出力
- 終了ステータスを呼び出し元へ返却

---

## メリット

- SQL実行処理を1か所へ集約できる
- ログ取得方法を統一できる
- SQL実行仕様の変更が容易になる
- 各スクリプトは本来の業務処理だけを担当できる
- 保守性・再利用性を向上できる