# register_cron.sh

## 概要

`register_cron.sh` は、SQLStudyで使用するcron設定を現在の環境に合わせて生成し、crontabへ登録するためのスクリプト。

cronファイルへ `/mnt/c/DEV/SQLStudy` などの固定絶対パスを直接記述すると、SQLStudyの配置場所が変わった場合に動作しなくなる。

そのためcronファイルでは、

```text
${BASE_DIR}/pubfun/write_shell_log.sh
${BASE_DIR}/sqlfun/bk_db.sh
```

のように `${BASE_DIR}` を使用したテンプレートとして管理する。

`register_cron.sh` の実行時にSQLStudyの実際の絶対パスを取得し、`${BASE_DIR}` の部分だけを置換してcrontabへ登録する。

## 作成目的

・cronの固定絶対パスへの依存をなくす  
・SQLStudyの配置場所が変わってもcronを登録できるようにする  
・cronファイル自体は環境に依存しないテンプレートとして管理する  
・cron登録処理をスクリプト化し、手作業によるパス修正を不要にする  

## 使用ファイル

### cron_targets.conf

cronから使用する対象ファイル名を管理する。

```text
write_shell_log.sh
bk_db.sh
```

### db_bk.cron

実際に登録するcron設定のテンプレート。

```cron
45 23 * * * bash "${BASE_DIR}/pubfun/write_shell_log.sh" "${BASE_DIR}/sqlfun/bk_db.sh"
```

`${BASE_DIR}` は実際のパスではなく、登録時に置換するための目印として使用する。


## 処理の流れ

① `cron_targets.conf` の存在確認

② `while read` で対象ファイル名を1行ずつ取得

③ `find` でSQLStudy配下から対象ファイルを検索

④ 検索結果を確認
- 0件 → エラー終了
- 複数件 → 同名ファイルが存在するためエラー終了
- 1件 → 絶対パスを取得

⑤ 取得した絶対パスから `awk` を使用してSQLStudyまでのパスを取得

```text
/mnt/c/DEV/SQLStudy/sqlfun/bk_db.sh
              ↓
/mnt/c/DEV/SQLStudy
```

⑥ `sed` で `db_bk.cron` の `${BASE_DIR}` を実際のSQLStudyのパスへ置換

```text
${BASE_DIR}/sqlfun/bk_db.sh
              ↓
/mnt/c/DEV/SQLStudy/sqlfun/bk_db.sh
```

⑦ 置換後のcron設定を `cron_record` に保持

元の `db_bk.cron` は書き換えないため、`${BASE_DIR}` を使用したテンプレートの状態を維持する。

⑧ 生成したcron設定を表示

⑨ `read -p` で登録確認

⑩ `y` の場合のみ `crontab` へ登録

⑪ `crontab -l` で登録結果を確認


## 実行イメージ

```text
cron_targets.conf
        ↓
対象ファイルを検索
        ↓
絶対パスを取得
        ↓
SQLStudyまでのパスを取得
        ↓
db_bk.cron
${BASE_DIR}
        ↓
実環境の絶対パスへ置換
        ↓
cron設定を表示
        ↓
登録確認
        ↓
crontabへ登録
```


## 実装結果

正常系テストを実施し

・cron対象ファイルの検索  
・対象ファイルの0件／複数件判定  
・SQLStudyまでの絶対パス取得  
・`${BASE_DIR}` の置換  
・元のcronテンプレートの維持  
・登録前の確認  
・crontabへの登録  
・`crontab -l` による登録結果確認  

まで正常に動作することを確認した。
