#gsave関数の中身　GitHubのタイトルを生成　～　GitHubへアップロード自動化

#!/bin/bash

#変更されたフォルダ名を取得

local changed_dirs=$(git diff --name-only | cut -d / -f 1 | sort -u )

#変更日を取得

local today=$(date +%F)

#変更時間を取得

local now_time=$(date +%H%M)

#既存のファイル変更時のタイトル

local git_title="$changed_dirs"_"$today"_"$now_time" 

