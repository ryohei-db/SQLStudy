# GitHub Actions（CI）・ShellCheck

## 概要

`SQLStudy` のシェルスクリプト数が増えてきたため、コード品質を維持しながら開発を進められるよう、自動チェック環境を導入する。

これまでは手動で動作確認を行っていたが、記述ミスや危険な書き方を早い段階で発見できるよう、VS Code と GitHub の両方で ShellCheck を利用した品質管理を行う。

---

## 導入目的

- シェルスクリプトの品質向上
- 記述ミス・危険な書き方の早期発見
- Push時の自動チェックによる品質管理
- GitHub Actions（CI）の学習・実践
- 実践的な開発環境・ポートフォリオの構築

---

## CIとは

CI（Continuous Integration：継続的インテグレーション）は、コードを GitHub に Push するたびに、自動でテストや品質チェックを実行する仕組みである。

今回は ShellCheck によるシェルスクリプトの自動チェックを対象とし、CD（自動デプロイ・自動公開）は実装しない。

---

## ShellCheckとは

ShellCheck はシェルスクリプト専用の静的解析ツールであり、コードを実行せずに記述内容を解析し、問題点や改善点を指摘する。

主な確認内容

- 構文エラー
- ダブルクォート漏れ
- 未使用変数
- 危険な変数展開
- Bash特有の注意点
- 可読性・保守性の改善提案

ShellCheck の指摘は必ず修正するのではなく、内容を理解した上で必要に応じて対応する。

---

## 導入内容

### VS Code

ShellCheck拡張機能を導入し、シェルスクリプト作成中にリアルタイムで自動チェックを行う。

開発中に問題を発見・修正できるため、ミスを早い段階で防止できる。

---

### GitHub Actions（CI）

GitHubへPushしたタイミングで GitHub Actions を実行し、リポジトリ内の全シェルスクリプトに対して ShellCheck を自動実行する。

Push後も品質確認を自動化することで、公開コードの品質維持を図る。

---

## 開発フロー

```text
シェルスクリプト作成
        ↓
VS Code（ShellCheck）
        ↓
動作確認
        ↓
gsave
        ↓
GitHubへPush
        ↓
GitHub Actions（CI）
        ↓
ShellCheck実行
        ↓
結果をGitHub上で確認
```

---

## 運用方針

- 開発中は VS Code の ShellCheck でリアルタイムチェック
- Push後は GitHub Actions で最終チェック
- リポジトリ内の全 `.sh` ファイルを対象とする
- 現在のコーディング方針を維持したまま品質向上を図る
- CIによる継続的な品質管理を行う

---

## まとめ

`SQLStudy` では、VS Code と GitHub Actions の両方に ShellCheck を導入し、開発中と GitHub 公開後の二段階でシェルスクリプトの品質を確認する。

これにより、Linux・Shell Script・Git・GitHub Actions を組み合わせた、実践的な開発・品質管理環境を構築する。