# 環境依存からの脱却

## 目的・経緯

これまでは自分の環境で使用することを前提としていたため
`/mnt/c/DEV/SQLStudy` などの固定パスを使用していた。

今後はGitHubでの公開・第三者利用を想定し
SQLStudyの配置場所が変わっても動作できる構成へ変更する。

絶対パスの使用自体をなくすのではなく
固定された絶対パスへの依存をなくし
`BASE_DIR` を基準に環境に応じた絶対パスを生成する設計とする。

## 今回実施したこと：設定ファイル・ログ周りの整理

各スクリプトで、自身の位置から `BASE_DIR` を取得する。

```bash
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
```

その後、`setting.conf` を読み込む。

```bash
source "${BASE_DIR}/config/setting.conf"
```

処理の流れを以下に統一する。

```text
各スクリプト
    ↓
BASE_DIRを取得
    ↓
setting.confを読み込む
    ↓
DB / LOG_DIRなどをBASE_DIR基準で使用
```

## setting.conf の変更

固定されていた以下の定義を削除。

```bash
BASE_DIR="/mnt/c/DEV/SQLStudy"
```

`BASE_DIR` は各スクリプト側で取得し、
`setting.conf` では取得済みの `BASE_DIR` を利用する。

```bash
DB="${BASE_DIR}/db/study.db"
LOG_DIR="${BASE_DIR}/logs"
```

これにより、SQLStudyの配置場所が変わっても
DB・ログなどのパスが自動的に追従する。


## 動作確認

既存スクリプトが

```bash
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "${BASE_DIR}/config/setting.conf"
```

の順番で処理されていることを確認。

変更後もログが正常に記録されることを確認したため
設定ファイル・ログ周りについては問題なし。

## 固定パスの洗い出し・パス管理方法について

当初予定していた、

1. 固定パスの洗い出し
2. パス管理方法の整理

については、パス設計の方針がおおむね決まっているため
事前にすべて洗い出す作業は行わない。

今後は各機能を改修する際に対象ファイルを確認し
環境依存している箇所があればその都度修正する。

## 今後の対応

・cronの固定パス依存を解消する  
・cron登録用スクリプト `register_cron.sh` を作成する  
・`.bashrc` に依存しない共通の実行入口を作成する  
・既存機能を確認しながら環境依存箇所を順次修正する