# SQLStudy

SQL / Linux / SQLite 学習環境

## Purpose : 目的

- SQLを実行するだけでなく、Linux・SQLite・Gitの理解を深めながら、学習・検証環境を構築しています。
- Bashによる自動化を通して、作業ミスや手間を削減し、開発効率の向上を目指しています。
- 最終目標は、Pythonで作成したGUIツールと連携し、SQL実行や環境構築を効率化することです。
- 将来的にはDocker上のMySQL環境にも対応し、複数のデータベースで検証できる環境を構築する予定です。

## Design Documents ：基本設計　

設計の詳細は docs を参照してください。

- GitHub導入の経緯
- スクリプトへ移行した理由
- BASE_DIR設計
- DB設計
- 変数・関数設計


## Environment ：使用ツール
- Ubuntu
- SQLite
- VSCode
- DBeaver

## Features : 主な機能
- init_sql() : CREATE・INSERTを自動実行し、初回のテーブル作成とデータ登録を自動化
- gsave() : タイトルの生成と命名、GitHubへのアップロードを自動化
- reset_table() : テーブルの存在確認・実行確認を行い、安全にDROP TABLEを実行
- select_file() :対象ファイルの選択・存在確認・実行を行う共通実行基盤