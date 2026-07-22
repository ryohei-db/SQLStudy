# SQLStudy

SQL / Linux / SQLite 学習環境

## Purpose : 目的

- SQLを実行するだけでなく、Linux・SQLite・Gitの理解を深めながら、学習・検証環境を構築しています。
- Bashによる自動化を通して、作業ミスや手間を削減し、開発効率の向上を目指しています。
- 最終目標は、Pythonで作成したGUIツールと連携し、SQL実行や環境構築を効率化することです。
- 将来的にはDocker上のMySQL環境にも対応し、複数のデータベースで検証できる環境を構築する予定です。

## ディレクトリ構成

- `db/`
  - SQLite データベースファイルを管理する。

- `db_backup/`
  - データベースのバックアップを保存する。

- `docs/design/`
  - 設計方針や各スクリプトの概要を管理する。

- `docs/development_log/`
  - 開発中の検討内容や設計変更の履歴を記録する。

- `docs/script_features/`
  - 各スクリプト・関数の機能仕様をまとめる。

- `docs/test/`
  - 動作確認・検証結果を記録する。

- `pubfun/`
  - 複数の機能で共通利用するスクリプトを配置する。

- `sql/`
  - 学習用 SQL や CREATE・INSERT・RESET などを管理する。

- `sqlfun/`
  - SQL 関連の処理を行うスクリプトを配置する。


## ディレクトリ構成 (樹形図)

`````









`````

## Environment ：使用ツール
- Ubuntu
- SQLite
- VSCode
- DBeaver

## Features : 主な機能

- `init_sql()` : CREATE・INSERT を自動実行し、初回のテーブル作成とデータ登録を自動化
- `update_readme()` : `tree` コマンドで取得した最新のディレクトリ構成を README へ自動反映
- `gsave()` : README の更新、コミットメッセージ生成、GitHub へのアップロードを自動化
- `reset_table()` : テーブルの存在確認・実行確認を行い、安全に `DROP TABLE` を実行
- `select_file()` : 対象ファイルの選択・存在確認・実行を行う共通実行基盤
- `bk_db()` : SQLite データベースを日時付きでバックアップし、古いバックアップを自動削除


