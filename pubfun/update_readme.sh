#!/bin/bash

# update_readme() の中身

# 開発の基準となるSQLStudy の絶対パスを取得する

BASE_DIR="$(cd "$(dirname "${BASH_SORUCE[0]}")/.." && pwd)"

# SQLStudyへ移動し、treeコマンドの実行結果を変数へ保存する

TREE_DATA="$(cd "${BASE_DIR}" && tree -I ".git")"


README=""${BASE_DIR}"/README.md"

NEW_README="$(

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

' "${README}")"


if [ $? -ne 0 ]; then

    exit 1
fi










