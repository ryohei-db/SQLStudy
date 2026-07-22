# gsave 改良内容

## 追加する機能

- `tree` コマンドで取得した最新のディレクトリ構成を README へ反映する。
- cron の定期実行設定を README へ反映する。:　`この機能は実装しない理由は下記に記載`

---

# cron 実行時の仕様

- cron はバックグラウンドで実行されるため、通常のターミナルのように実行結果は画面へ表示されない。
- 実行結果やエラー内容を確認する場合は、標準出力・標準エラー出力をログファイルへリダイレクトする。

例

```cron
*/2 * * * * bash "/path/to/script.sh" >> /tmp/script.log 2>&1
```

---

# 検証結果

## GitHub への push

cron から `git push` を実行したところ、GitHub の認証情報を取得できず、以下のエラーが発生した。

```text
fatal: could not read Username for 'https://github.com': No such device or address
```

その結果、

- `git add`：成功
- `git commit`：成功
- `git push`：失敗

となることを確認した。

このため、`gsave` は cron による自動実行ではなく、手動実行を前提とした運用とした。

---

## 複数ジョブの登録

`crontab` は登録時に既存の設定を置き換える。

例えば、

```bash
crontab cron/gsave.cron
```

を実行すると、以前登録していた `bk_db.sh` のジョブは削除される。

複数の定期実行を行う場合は、1つの `crontab` に複数のジョブを記述して登録する必要がある。

例

```cron
45 23 * * * bash "/mnt/c/DEV/SQLStudy/sqlfun/bk_db.sh"
*/2 * * * * bash "/mnt/c/DEV/SQLStudy/pubfun/gsave.sh" >> /tmp/gsave.log 2>&1
```

## cron による自動実行を実装しない理由

`gsave` を cron から実行したところ、`git add` と `git commit` は正常に実行されたが、`git push` では GitHub の認証情報を取得できず、以下のエラーが発生した。

```text
fatal: could not read Username for 'https://github.com': No such device or address
```

また、cron はバックグラウンドで実行されるため、通常のターミナルのような対話入力を行えない。

`gsave` は実行結果を確認しながら使用する処理であり、`git push` まで自動化できない場合は cron へ登録する利点が小さい。

そのため、`gsave` の cron による定期実行は実装せず、手動実行を前提とした運用とする。

---

## 誤って登録した内容の削除

`gsave` の検証用に作成した `cron/gsave.cron` からジョブを削除し、変更後の設定ファイルを再登録する。

```bash
crontab cron/gsave.cron
```

登録結果を確認する。

```bash
crontab -l
```

不要になった `cron/gsave.cron` ファイルを削除する。

```bash
rm cron/gsave.cron
```

なお、`crontab` は登録時に既存の設定を置き換えるため、`bk_db.sh` など残す必要があるジョブは、再登録する設定ファイル内に記述しておく。

## cronに登録してしまった内容を削除する

① `cron/gsave.cron` の中身を削除する（またはファイルを空にする）。

② 空の内容を再登録する。

```bash
crontab cron/gsave.cron
```

③ 登録内容が削除されたことを確認する。

```bash
crontab -l
```

④ cron登録用ファイルを削除する。

```bash
rm cron/gsave.cron
```

または、エクスプローラーから直接ファイルを削除する。

⑤ ファイルが削除されたことを確認する。

```bash
ls cron
```

## README のディレクトリ構成を自動更新する方針

`tree` コマンドで取得した最新のディレクトリ構成を README へ反映する機能を追加する。

README 更新処理は `update_readme.sh` として独立したスクリプトを作成し、

- `tree` コマンドでディレクトリ構成を取得する
- 一時ファイルへ保存する
- README のディレクトリ構成を最新の内容へ更新する

処理を担当させる。

`gsave.sh` は README 更新スクリプトを実行した後、Git の add・commit・push を行う構成とする。


# `tree` コマンドで取得した最新のディレクトリ構成を README へ反映する。