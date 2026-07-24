# gsave を cron で実行したときの動作テスト記録

## テスト内容

`gsave.sh` を cron に登録し、定期実行した場合の動作を確認した。

```cron
*/2 * * * * bash "/mnt/c/DEV/SQLStudy/pubfun/gsave.sh" >> /tmp/gsave.log 2>&1
```

## テスト結果

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

## 複数ジョブを登録したときの動作

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

## gsave を cron で実行したときの動作テスト記録の最終まとめ

`gsave` の cron 実行について動作検証を実施した。

その結果、`git add` および `git commit` は正常に実行できたが、`git push` は GitHub の認証情報を取得できず失敗することを確認した。

また、`crontab` は登録時に既存の設定を置き換えるため、複数のジョブを登録する場合は 1 つの `crontab` にまとめて記述する必要があることを確認した。

以上の結果から、本プロジェクトでは `gsave` の cron による自動実行は採用せず、手動実行を前提とした運用とする。

---

## 実装方針の変更

今回の検証結果を踏まえ、`gsave` を cron による定期実行とする機能の実装は行わないこととした。

今後は手動実行を前提とし、GitHub への保存処理や README 更新などの機能追加・改善を優先して実装を進める。


# `tree` コマンドで取得した最新のディレクトリ構成を README へ反映する。


