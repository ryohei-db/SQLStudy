#gsave関数の中身　GitHubのタイトルを生成　～　GitHubへアップロード自動化

#!/bin/bash

#変更されたフォルダ名を取得

changed_dirs="$(git diff --name-only | cut -d / -f 1 | sort -u )"

#変更日を取得

today="$(date +%F)"

#変更時間を取得

now_time="$(date +%H%M)"

#既存のファイル変更時のタイトル　＊変更には対応できるが、新規作成ファイルには対応不可のため改善版を用意する必要あり

no_git_title="${changed_dirs}_${today}_${now_time}"


#変更・新規作成されたファイルのディレクトリ

n_changed_dirs="$(git status --short | awk '{print $2}' | cut -d / -f 1 | sort -u)"

#変更・新規作成時のタイトル　＊変更・新規作成ファイルにも対応した改善版

git_title="${n_changed_dirs}_${today}_${now_time}"

# .bashrc の BASE_DIR は .bashrc の位置を基準としているため、このスクリプトでは使用できない
# このスクリプトを基準とした BASE_DIR を作成する

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 1 : ルートディレクトリである　SQL_Study　へ移動する

cd "${BASE_DIR}"

# 2 : 新規・変更があるかを確認

git status

# 3 : SQLStudy(ルートディレクトリ)直下のファイルを含める

git add .

# 4 : 保存時のタイトルを自動生成する

git commit -m "${git_title}"

# 5 GitHubへアップロード

git push















