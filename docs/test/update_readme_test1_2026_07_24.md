## update_readme() テスト・修正記録

### 1回目：単体実行

#### 実行内容

`update_readme` を単体で実行し、README の自動更新処理を確認。

#### 実行結果

- `BASE_DIR` が `/mnt/c` となり、`tree` が `/mnt/c` 配下を走査
- 処理が終了せず停止
- `bash -x` でデバッグを実施
- `BASH_SOURCE[0]` が正しく取得できていないことを確認

#### 修正方法

- `BASE_DIR` の取得方法を `BASH_SOURCE[0]` から `$0` へ変更

### 2回目：修正後の動作確認

#### 実行内容

`update_readme` を再実行し、修正後の動作を確認。

#### 実行結果

- `BASE_DIR` が `/mnt/c/DEV/SQLStudy` として取得されることを確認
- `tree` の実行結果を正常に取得
- `README.md` のディレクトリ構成が正常に更新されることを確認
- エラーなく処理が終了することを確認

### 3回目：TREE_START が存在しない場合

#### 実行内容

`README.md` の `<!-- TREE_START -->` を削除した状態で `update_readme` を実行。

#### 実行結果

- `<!-- TREE_START -->` が存在しないことを検出
- `エラー: <!-- TREE_START --> が見つかりません。` を表示
- `exit 1` で処理を終了
- `README.md` が更新されないことを確認

### 4回目：TREE_END が存在しない場合

#### 実行内容

`README.md` の `<!-- TREE_END -->` を削除した状態で `update_readme` を実行。

#### 実行結果

- `<!-- TREE_END -->` が存在しないことを検出
- `エラー: <!-- TREE_END --> が見つかりません。` を表示
- `exit 1` で処理を終了
- `README.md` が更新されないことを確認