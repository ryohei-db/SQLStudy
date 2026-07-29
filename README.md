# SQLStudy

SQL / Linux / SQLite 学習環境

## Purpose : 目的

- SQLを実行するだけでなく、Linux・SQLite・Gitの理解を深めながら、学習・検証環境を構築しています。
- Bashによる自動化を通して、作業ミスや手間を削減し、開発効率の向上を目指しています。
- 最終目標は、Pythonで作成したGUIツールと連携し、SQL実行や環境構築を効率化することです。
- 将来的にはDocker上のMySQL環境にも対応し、複数のデータベースで検証できる環境を構築する予定です。

## ディレクトリ構成

- `.github/`
  - GitHub 関連の設定を管理する。

- `.github/workflows`
  - GitHub Actions の Workflow ファイルを配置する。

- `.vscode/`
  - プロジェクトで共通利用する VS Code の設定を管理する。

- `config/`
    - リポジトリ全体で共通利用する設定ファイル（.conf）を管理する。

- `cron/`
  - 定期実行で使用する cron 設定ファイルを管理する。

- `db/`
  - SQLite データベースファイルを管理する。

- `db_backup/`
  - データベースのバックアップを保存する。

- `docs/design/`
  - 設計方針や導入理由などの設計資料を管理する。

- `docs/development_log/`
  - 開発中の検討内容や設計変更の履歴を記録する。

- `docs/script_features/`
  - 各スクリプト・関数の機能仕様をまとめる。

- `docs/test/`
  - 動作確認・検証結果を記録する。

- `logs/`
 - 実行ログを保存する

- `pubfun/`
  - 複数の機能で共通利用するスクリプトを配置する。

- `sql/`
  - 学習用 SQL や CREATE・INSERT・RESET などを管理する。

- `sqlfun/`
  - SQL 関連の処理を行うスクリプトを配置する。



## ディレクトリ構成 (樹形図)

<!-- TREE_START -->
```text
.
├── .github
│   └── workflows
│       └── shellcheck.yml
├── .vscode
│   └── settings.json
├── README.md
├── config
│   └── setteing.conf
├── cron
│   └── db_bk.cron
├── db
│   └── study.db
├── db_backup
│   ├── study_20260721171001.db
│   ├── study_20260721171201.db
│   ├── study_20260721234500.db
│   ├── study_20260723234500.db
│   ├── study_20260724234502.db
│   ├── study_20260726234500.db
│   └── study_20260728234500.db
├── docs
│   ├── design
│   │   ├── BASE_DIR_2026_07_29.md
│   │   ├── BASE_DIR_what.md
│   │   ├── DB_what.md
│   │   ├── GitHub_Actions_CI_shellcheck.md
│   │   ├── coding_style_2026_07_27.md
│   │   ├── github_purpose.md
│   │   ├── log_design.md
│   │   ├── scripts_purpose.md
│   │   └── sql_execution_flow.md
│   ├── development_log
│   │   ├── GitHub_Actions_CI_shellcheck_log.md
│   │   ├── bk_db_log.md
│   │   ├── bk_dk_cron_log.md
│   │   ├── gsave_ver1.01_log.md
│   │   ├── log_sql.sh_logs.md
│   │   ├── reset_table_log.md
│   │   ├── select_file_log.md
│   │   └── update_readme_log.md
│   ├── script_features
│   │   ├── bk_db.md
│   │   ├── gsave.md
│   │   ├── gsave_ver1.01.md
│   │   ├── init_sql.md
│   │   ├── log_sql.md
│   │   ├── reset_table.md
│   │   ├── select_file.md
│   │   └── update_readme.md
│   └── test
│       ├── bk_db_test1_2026_07_21.md
│       ├── gsave_test_1_2026_07_06.md
│       ├── gsave_ver1.01_test1_2026_07_24.md
│       ├── init_sql_test_1_2026_07_12-14.md
│       ├── init_sql_test_2_2026_07_16.md
│       ├── reset_table_test_1_2026_07_12-14.md
│       ├── reset_table_test_2_2026_07_16.md
│       ├── select_file_test_1_2026_07_16.md
│       └── update_readme_test1_2026_07_24.md
├── logs
├── pubfun
│   ├── gsave.sh
│   ├── select_file.sh
│   ├── update_readme.sh
│   └── write_shell_log.sh
├── sql
│   ├── EXISTS
│   │   ├── CREATE.sql
│   │   ├── INSERT.sql
│   │   └── SELECT.sql
│   ├── HAVING
│   │   ├── CREATE.sql
│   │   ├── INSERT.sql
│   │   ├── RESET.sql
│   │   └── SELECT.sql
│   ├── OUTER_JOIN
│   │   ├── CREATE.sql
│   │   ├── INSERT.sql
│   │   └── SELECT.sql
│   ├── SELF_JOIN
│   │   ├── CREATE.sql
│   │   ├── INSERT.sql
│   │   └── SELECT.sql
│   └── test
│       └── scratch.sql
└── sqlfun
    ├── bk_db.sh
    ├── init_sql.sh
    ├── log_sql.sh
    └── reset_table.sh

22 directories, 69 files
```
<!-- TREE_END -->

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

## Automation ： 自動化

- `cron` ： `bk_db.sh` を定期実行し、SQLite データベースのバックアップを自動作成

## Quality Control ： 品質管理

- `ShellCheck` ： シェルスクリプトの構文・記述上の問題を自動チェック
- `GitHub Actions` ： push時にShellCheckを自動実行し、問題の早期発見を実施
