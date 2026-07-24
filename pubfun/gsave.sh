#!/bin/bash

#gsave関数の中身　GitHubのタイトルを生成　～　GitHubへアップロード自動化
# .bashrc の BASE_DIR は .bashrc の位置を基準としているため、このスクリプトでは使用できない
# このスクリプトを基準とした BASE_DIR を作成する

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 1 : SQL_Study　へ移動する

cd "${BASE_DIR}"

if [ $? -ne 0 ]; then
    echo "エラー：SQLStudyへの移動に失敗しました。" >&2
    exit 1
fi


# README を更新する　update_readme.sh を実行する

bash "/mnt/c/DEV/SQLStudy/pubfun/update_readme.sh"

if [ $? -ne 0 ]; then

    echo "update_readmeの実行(READMEの更新)に失敗しました" >&2

    exit 1

fi

#変更日を取得

today="$(date '+%F')"

#変更時間を取得

now_time="$(date '+%H%M')"


#変更・新規作成されたファイルのディレクトリ

n_changed_dirs="$(git status --short | awk '{print $2}' | cut -d / -f 1 | sort -u | tr '\n' '_')"


#変更・新規作成時のタイトル　＊変更・新規作成ファイルにも対応した改善版

git_title="${n_changed_dirs}_${today}_${now_time}"


# 2 : 新規・変更があるかを確認、なければ終了

if git status --short | grep -q .; then
    echo "変更・新規作成あり"
else
    echo "変更なし"
    exit 0
fi

# 3 : SQLStudy直下のファイルを含め、git add.後の状態を表示

git add .

if [ $? -ne 0 ]; then

    echo "エラー : git add. に失敗しました" >&2

    exit 1
fi

echo "===========git add .後の状態==========="
git status --short


# 4 : 保存時のタイトルを自動生成し、生成されたタイトルを表示する

echo "コミットタイトル：${git_title}"

git commit -m "${git_title}"

if [ $? -ne 0 ]; then

    echo "エラー : git commit に失敗しました" >&2

    exit 1
fi


# 5 GitHubへアップロード、生成されたタイトルを表示、アップロード後の状態を表示

git push

if [ $? -ne 0 ]; then

    echo "エラー : git push に失敗しました" >&2

    exit 1
fi


echo "アップロード完了 : ${git_title}"
echo "=============アップロード後の状態=================="
git status
















