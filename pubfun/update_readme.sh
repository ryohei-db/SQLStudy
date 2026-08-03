#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${BASE_DIR}/config/setting.conf"


# update_readme() の中身

# SQLStudyへ移動し、treeコマンドの実行結果を変数へ保存する .gitディレクトリは除外する
# ただし　.がついている隠しディレクトリである　.githubディレクトリは表示させる

TREE_DATA="$(cd "${BASE_DIR}" && tree -a -I ".git")"

# README を表すファイルパス

README="${BASE_DIR}/README.md"

# READMEの更新結果
# <!-- TREE_START --> が見つかれば <!-- TREE_START --> を出力、その次の行を読み進める
# <!-- TREE_END --> が見つかれば ディレクトリツリー、<!-- TREE_END -->を出力、その次の行を読み進める
# <!-- TREE_START -->　<!-- TREE_END -->　の前後も出力し、READMEの内容をそのまま出力
# <!-- TREE_START --> が最後まで見つからないなら、エラーで終了

if ! NEW_README="$(

awk -v tree_data="${TREE_DATA}" '

/<!-- TREE_START -->/ {

    flag=1
    found=1
    print
    next

}

flag && /<!-- TREE_END -->/ {


    end_found=1

    print "```text"
    print tree_data
    print "```"
    print
    flag=0
    next

}

!flag {

    print

}

END {

    if (!found) {

        print "エラー: <!-- TREE_START --> が見つかりません。" > "/dev/stderr"
        
        exit 1

    }


    if (!end_found) {


        print "エラー : <!-- TREE_END --> が見つかりません。" > "/dev/stderr"

        exit 1
    }

}

' "${README}")"; then

    exit 1
fi

# 置き換え・出力結果を README.md へ反映する

printf '%s\n' "${NEW_README}" > "${README}"









