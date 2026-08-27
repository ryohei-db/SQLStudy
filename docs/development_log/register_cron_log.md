# register_cron.sh 開発記録

## 目的

cron設定に絶対パスを直接記述すると、SQLStudyの配置場所が変わった場合にcronが動作しなくなる。

そのため、環境ごとのSQLStudyの絶対パスを取得し、cron登録時に `${BASE_DIR}` を実際のパスへ置換して登録する `register_cron.sh` を作成する。

## 今回実装した処理

### 1. cron対象ファイルの管理

`cron_targets.conf` に定期実行で使用するファイル名を記載する。

```text
write_shell_log.sh
bk_db.sh
```

`register_cron.sh` から `while read` を使用して1行ずつ読み込む。

### 2. 対象ファイルの検索・確認

取得したファイル名を `find` でSQLStudy配下から検索する。

検索結果は以下のように判定する。

- 0件 → 対象ファイルが存在しないためエラー
- 2件以上 → 同名ファイルが複数存在するためエラー
- 1件 → 正常として絶対パスを取得

検索件数の確認には `wc -l` を使用する。

### 3. SQLStudyまでの絶対パスを取得

取得した対象ファイルの絶対パスを `awk` で `/` ごとに分割する。

`for` 文で各項目を順番に確認し、`SQLStudy` が見つかったところまでパスを組み立てる。

これにより、SQLStudyの配置場所を固定せず

```text
/mnt/c/DEV/SQLStudy
```

のような実際の環境のパスを取得できる。

### 4. cron設定のBASE_DIRを置換

`db_bk.cron` では絶対パスを直接記述せず

```text
${BASE_DIR}/pubfun/write_shell_log.sh
${BASE_DIR}/sqlfun/bk_db.sh
```

のように `${BASE_DIR}` を目印として記述する。

`sed` を使用して `${BASE_DIR}` の部分だけを、取得したSQLStudyの絶対パスへ置換する。

元の `db_bk.cron` は書き換えず、置換後の内容を `cron_record` 変数へ格納する。

これにより、`db_bk.cron` は環境に依存しないテンプレートとして残すことができる。

生成したcron設定を表示し、

```text
この内容でcronを登録しますか？ y/n :
```

と `read -p` で確認する。

`y` が入力された場合のみ、

```text
cron_record
↓
printfで標準出力
↓
パイプ
↓
crontab -
↓
cronへ登録
```

という流れで登録する。

## 処理全体の流れ

cron_targets.confを読み込む
↓
対象ファイル名を1行ずつ取得
↓
findで対象ファイルを検索
↓
0件・複数件をチェック
↓
対象ファイルの絶対パスを取得
↓
awkでSQLStudyまでの絶対パスを取得
↓
db_bk.cronの `${BASE_DIR}` をsedで置換
↓
置換結果をcron_recordへ格納
↓
生成したcron設定を表示
↓
readで登録確認
↓
yならcrontabへ登録

## 現在の状態・次回

cron登録用の実行行を環境に合わせて自動生成し、確認後にcrontabへ渡すところまで実装した。

次回は `register_cron.sh` を実際に実行して登録結果を確認する。

また、現在の `crontab -` による登録では既存のcrontabを置き換えるため、既存設定を消さずに追加・更新できる方法も検討する。