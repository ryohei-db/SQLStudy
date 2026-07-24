## update_readme() の機能

### 概要

- README のディレクトリ構成を自動更新する機能
- `tree` コマンドで最新のディレクトリ構成を取得する
- `README.md` の `<!-- TREE_START -->` ～ `<!-- TREE_END -->` の範囲のみを書き換える
- 指定範囲以外の README の内容は保持する
- `.bashrc` の `update_readme` 関数を入口として、`update_readme.sh` を呼び出して実行する

### 主な機能

- `BASE_DIR` を基準に `README.md` の絶対パスを取得
- `tree -I ".git"` を実行し、最新のディレクトリ構成を取得
- `awk` を利用して README を読み込み、指定範囲のみを置換
- `TREE_START`・`TREE_END` が存在しない場合はエラーメッセージを表示して終了
- 更新後の内容を `printf` で `README.md` へ反映
- 終了ステータスを利用して処理の成功・失敗を判定

### 作成経緯

- README のディレクトリ構成を手動で更新しており、更新漏れや内容の不一致が発生する可能性があった
- 毎回 `tree` の結果をコピー＆ペーストする手間をなくしたかった
- `gsave.sh` 実行時に README も最新状態へ更新できるようにしたかった
- 他のスクリプトから共通利用できるよう、単独実行可能なスクリプトとして設計した

### 設計

- `update_readme` 関数を CLI から実行するための入口とする
- 実処理は `update_readme.sh` に分離する
- `BASE_DIR` を基準に `README.md` の絶対パスを生成する
- `tree -I ".git"` で最新のディレクトリ構成を取得する
- `awk` を利用して `TREE_START` ～ `TREE_END` の範囲のみを書き換える
- 指定範囲以外の README の内容は保持する
- `TREE_START`・`TREE_END` の存在を確認し、存在しない場合は `exit 1` で終了する
- 更新結果を `printf` で `README.md` へ上書きする
- 他スクリプトからは `bash update_readme.sh` として呼び出せる構成とする
- 実行結果は終了ステータスで判定し、正常終了は `exit 0`、異常終了は `exit 1` とする