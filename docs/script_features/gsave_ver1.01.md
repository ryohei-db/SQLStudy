## gsave 改良内容

### 概要

`gsave.sh` の実行時に README のディレクトリ構成も自動更新するよう改良する。

これまで `gsave.sh` は、変更内容を取得してコミットタイトルを生成し、Git の `add`・`commit`・`push` を実行する構成だった。

改良後は、Git の保存処理を開始する前に `update_readme.sh` を実行し、`tree` コマンドで取得した最新のディレクトリ構成を README へ反映する。

---

### 改良内容

- `gsave.sh` の保存処理前に `update_readme.sh` を実行する
- README を最新状態へ更新してから変更の有無を確認する
- 内容に差分がない場合は Git は変更なしと判定する。
- README の更新内容も Git の保存対象に含める
- `update_readme.sh` の実行に失敗した場合は、エラーメッセージを表示して処理を終了する
- `git add`・`git commit`・`git push` の各処理にエラー判定を追加する
- 処理が失敗した場合は、後続処理へ進まず `exit 1` で終了する
- SQLStudy への移動に失敗した場合もエラー終了する

---

### 改良後の処理の流れ

1. `BASE_DIR` を取得する
2. SQLStudy へ移動する
3. `update_readme.sh` を実行する
4. README のディレクトリ構成を最新状態へ更新する
5. Git の変更有無を確認する
6. 変更されたディレクトリを取得する
7. コミットタイトルを自動生成する
8. `git add .` を実行する
9. `git commit` を実行する
10. `git push` を実行する
11. アップロード後の状態を表示する

---

### 設計方針

- README 更新処理は `update_readme.sh` に分離する
- `gsave.sh` は README 更新後に Git の保存処理を実行する
- `update_readme.sh` は `bash` コマンドで直接呼び出す
- README 更新後に変更確認を行い、README の更新だけでも保存対象に含める
- 各主要処理の終了ステータスを確認し、失敗時はその場で終了する
- 正常終了は `exit 0`、異常終了は `exit 1` とする

---

### 改良後の目的

`tree` コマンドで取得した最新のディレクトリ構成を README へ反映したうえで、Git の `add`・`commit`・`push` を実行する。

これにより、README の手動更新を不要にし、リポジトリの実際の構成と README の内容を常に一致させる。

