# GitHub Actions（ShellCheck）導入

## 概要

シェルスクリプトの品質確認を自動化するため、GitHub Actions を利用した CI 環境を構築した。

`git push` を契機に Workflow が実行され、リポジトリ内のシェルスクリプトを ShellCheck で静的解析する構成とした。

---

## 学習内容

### GitHub Actions の基本構成

Workflow は以下の構成で記述することを理解した。

- `name`：Workflow 名
- `on`：実行条件
- `jobs`：実行する処理
- `runs-on`：実行環境
- `steps`：実行手順

---

### steps の書き方

実行手順は `steps` に記述する。

主に利用する項目は以下の2種類。

- `uses`：用意されている GitHub Action を利用する
- `run`：実行したいコマンドを記述する

---

### リポジトリの取得

Workflow 実行時は実行環境が新しく作成されるため、最初にリポジトリを取得する必要がある。

```yaml
- uses: actions/checkout@v4
```

---

### ShellCheck の実行

リポジトリ内の `.sh` ファイルを検索し、検索結果を ShellCheck に渡して静的解析を行う。

```yaml
- run: find . -name "*.sh" | xargs shellcheck
```

処理の流れ

```text
find . -name "*.sh"
        │
        ▼
.sh ファイルを検索
        │
        ▼
xargs shellcheck
        │
        ▼
ShellCheck を実行
```

---

## 品質向上

ShellCheck は以下の二段階で実施する構成とした。

### ① VS Code

ShellCheck 拡張機能を導入し、コーディング中にリアルタイムで静的解析を行う。

- 記述中に警告を確認できる
- 修正を即座に反映できる
- 開発効率の向上

### ② GitHub Actions

コードを `push` すると Workflow が実行され、リポジトリ内のシェルスクリプトを再度 ShellCheck で検査する。

```yaml
- run: find . -name "*.sh" | xargs shellcheck
```

これにより、

- 開発中（VS Code）
- GitHub へ反映後（GitHub Actions）

の二段階で静的解析を実施する品質確認体制とした。

開発時の見落とし防止だけでなく、GitHub 上でも同一条件で再チェックできる構成としている。

## 完成した Workflow

```yaml
name: shellcheck

on:
  push:

jobs:
  shellcheck:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - run: find . -name "*.sh" | xargs shellcheck
```

---

## 学習で理解したこと

- GitHub Actions は GitHub 上で処理を自動実行する仕組み
- Workflow は YAML ファイルで定義する
- `steps` では実行する手順を順番に記述する
- `uses` は既存の GitHub Action を利用する
- `run` は Linux コマンドを実行する
- ShellCheck によりシェルスクリプトの静的解析を自動化できる

