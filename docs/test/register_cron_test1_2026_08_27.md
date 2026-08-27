# register_cron.sh 正常系テスト記録

## テスト目的

`register_cron.sh` を実行し、cronテンプレート内の `${BASE_DIR}` が実環境のSQLStudyまでの絶対パスへ正常に置換され、crontabへ登録できることを確認する。

## 実行方法

`select_file` から `register_cron.sh` を指定して実行した。

```text
select_file

格納フォルダ名：
pubfun

ファイル名：
register_cron.sh

実行方法：
bash

実行確認：
y
```

## 実行結果

`register_cron.sh` により、`db_bk.cron` の `${BASE_DIR}` が実際のSQLStudyまでの絶対パスへ置換された。

生成されたcron設定：

```cron
45 23 * * * bash "/mnt/c/DEV/SQLStudy/pubfun/write_shell_log.sh" "/mnt/c/DEV/SQLStudy/sqlfun/bk_db.sh"
```

生成内容を確認後

```text
この内容でcronを登録しますか？ y/n : y
```

として登録を実行した。

その後 `crontab -l` により、以下の内容が登録されていることを確認した。

```cron
45 23 * * * bash "/mnt/c/DEV/SQLStudy/pubfun/write_shell_log.sh" "/mnt/c/DEV/SQLStudy/sqlfun/bk_db.sh"
```

また、`select_file` 側でも、

```text
/mnt/c/DEV/SQLStudy/pubfun/register_cron.shファイル実行に成功しました
```

となり、スクリプトが正常終了したことを確認した。

## テンプレート確認

元の `db_bk.cron` は、

```cron
45 23 * * * bash "${BASE_DIR}/pubfun/write_shell_log.sh" "${BASE_DIR}/sqlfun/bk_db.sh"
```

のまま保持されていることを確認した。

そのため、元ファイルを直接書き換えず、

```text
db_bk.cron
    ↓
${BASE_DIR} を保持したテンプレート
    ↓
register_cron.sh実行
    ↓
実環境のSQLStudyまでの絶対パスを取得
    ↓
登録時のみ ${BASE_DIR} を置換
    ↓
crontabへ登録
```

という設計どおりに動作している。

## テスト結果

正常系テスト成功。

以下の動作を確認した。

- cron対象ファイルの検索成功
- SQLStudyまでの絶対パス取得成功
- `${BASE_DIR}` の置換成功
- 元の `db_bk.cron` が書き換えられていないことを確認
- 生成したcron設定の表示成功
- `y/n` による登録確認成功
- crontabへの登録成功
- `crontab -l` による登録内容確認成功
- `register_cron.sh` の正常終了を確認

## 今後の確認・改善

現在は正常系の登録処理まで確認済み。

