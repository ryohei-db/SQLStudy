# スクリプトファイルの実行方法の変更

## 変更目的

シェルスクリプトの実行方法を統一し、実行結果を共通ログとして記録できるようにする。

---

## 変更前

各関数から対象スクリプトを直接実行していた。

```text
関数
    ↓
対象シェルスクリプト
```

例

```bash
init_sql() {
    bash "${BASE_DIR}/sqlfun/init_sql.sh" "$@"
}
```

---

## 変更後

各関数は `write_shell_log.sh` を経由して対象スクリプトを実行する。

```text
関数
    ↓
write_shell_log.sh
    ↓
対象シェルスクリプト
```

例

```bash
init_sql() {
    bash "${BASE_DIR}/pubfun/write_shell_log.sh" \
        "${BASE_DIR}/sqlfun/init_sql.sh" "$@"
}
```

---

## write_shell_log.sh の役割

- 第1引数から実行対象のシェルスクリプトを受け取る
- `shift` により実行対象スクリプトを引数一覧から除外する
- 残った引数 (`"$@"`) を対象スクリプトへそのまま渡す
- `bash` で対象スクリプトを実行する
- SUCCESS / FAILED をシェルログへ記録する
- `exit 0` / `exit 1` を呼び出し元へ返す

---

## 引数の受け渡し

関数

```bash
bash write_shell_log.sh script.sh arg1 arg2
```

write_shell_log.sh

```text
実行前

$1 = script.sh
$2 = arg1
$3 = arg2
```

```bash
shell_target="$1"
shift
```

```text
shift後

$1 = arg1
$2 = arg2
```

実行

```bash
bash "${shell_target}" "$@"
```

↓

```bash
bash script.sh arg1 arg2
```

---

## 設計方針

- 関数をシェルスクリプト実行の入口とする
- 関数から対象スクリプトを直接実行しない
- 必ず `write_shell_log.sh` を経由して実行する
- ただし`gsave.sh` は、実行後のログ追記によって新たなGit差分が発生するため、シェルログの対象外とする。
- SQL実行は各スクリプト内で `log_sql.sh` を経由する
- シェルログとSQLログの責務を分離する

---

## メリット

- シェルスクリプトの実行方法を統一できる
- シェル実行ログを一元管理できる
- ログ取得処理を共通化できる
- 各スクリプトは本来の処理だけに集中できる
- 保守性・再利用性を向上できる


