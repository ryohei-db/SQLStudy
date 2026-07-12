## init_sql() テスト・修正記録


### 1回目：フォルダ名を誤って指定

実行：
`init_sql EXITS init_reset`

結果：
- 引数 `$1`、`$2` の入力を正常に受付
- `folder` に `EXITS` を格納
- `table_name` に `init_reset` を格納
- 入力内容の確認メッセージが正常に表示された
- 指定したフォルダに `CREATE.sql` が存在しないことを検出
- 「CREATE.sql が存在しません」と表示された
- 後続処理へ進まず終了

判定：`正常`

### 2回目：正しいフォルダ名・テーブル名を指定

実行：
`init_sql EXISTS init_reset`

結果：
- 引数 `$1`、`$2` を正常に受付
- 入力内容の確認メッセージが正常に表示された
- `init_reset` テーブルが存在しないことを確認
- テーブル作成処理へ進んだ
- `CREATE.sql` を実行
- `Meetings`、`TestScore` テーブルが既に存在するため `CREATE TABLE` に失敗
- CREATE.sqlの実行失敗を検出
- 失敗メッセージを表示して処理を終了

判定：`正常`

確認事項：
- テーブル存在確認は指定した1テーブルのみを対象としている
- CREATE.sql実行時はファイル内のCREATE文をすべて実行している
- 存在確認の単位とCREATE.sql実行の単位が一致していない
- 複数テーブルを作成するCREATE.sqlに対応するため、存在確認方法または実行方法の見直しが必要

### init_sql SQL実行方法の修正

#### 修正前

現在は、以下の処理でSQLファイル全体を実行している。

```bash
sqlite3 "${DB}" < "${create_file}"
sqlite3 "${DB}" < "${insert_file}"
```

この処理では、`CREATE.sql` および `INSERT.sql` に記述されているSQLが、先頭から最後まで実行される。

そのため、指定したテーブル以外の `CREATE TABLE` 文や `INSERT` 文も実行対象となる。

既に存在するテーブルに対して再度 `CREATE TABLE` を実行した場合、テーブル重複エラーが発生する。

---

#### 修正方針

`CREATE.sql` および `INSERT.sql` 全体を実行するのではなく、指定したテーブルに関係するSQLのみを取得して実行する。

---

#### CREATE.sql の修正内容

- `CREATE.sql` を読み込む
- `CREATE TABLE ${table_name}` を検索する
- 対象の `CREATE TABLE` 文の開始位置から、文末の `;` までを取得する
- 取得したSQLのみを `sqlite3` に渡して実行する

---

#### INSERT.sql の修正内容

- `INSERT.sql` を読み込む
- `${table_name}` を対象とする `INSERT` 文を検索する
- 対象テーブルの `INSERT` 文のみを取得する
- 取得したSQLのみを `sqlite3` に渡して実行する

---

#### 修正後の動作

- `CREATE.sql` から指定テーブルの `CREATE TABLE` 文のみ実行する
- `INSERT.sql` から指定テーブルの `INSERT` 文のみ実行する
- 指定していないテーブルのSQLは実行しない
- 既存テーブルに対する不要な `CREATE TABLE` の再実行を防止する
- 指定していないテーブルへの不要なデータ登録を防止する
