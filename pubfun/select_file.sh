#!/bin/bash
# select_file() の中身　

# $1(folder)にはBASE_DIR から見た格納フォルダパスを入力する

if [ -z "$1" ] || [ -z "$2" ]; then

    echo "入力方式 : 格納フォルダ名(二つ以上離れてたら相対パスで sql/EXISTSのようにして指定） ファイル名（拡張子が必要） 引数を入力してください.....入力待ち"

    read -r folder file_nm

    if [ -z "${folder}" ] || [ -z "${file_nm}" ]; then

        echo "入力値が空のままです"

        exit 1

    else

        echo "入力値が正常に入力されています"

    fi

else

    echo "格納フォルダ名 ファイル名 が正常に入力されいます"
    
    folder="$1"
    file_nm="$2"

    echo "格納フォルダ名 :${folder} 格納ファイル名 : ${file_nm} が入力されています"
    

fi

# select_file.sh の格納場所から1つ上へ移動
# SQLStudy を BASE_DIR とする

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 共通DBのパス

DB="${BASE_DIR}/db/study.db"


# 対象のファイルパス
# BASE_DIRを使用して作成しているので対象のファイルの絶対パスになっている
# そのため存在確認の判定値として利用する

tar_file_ps="${BASE_DIR}/${folder}/${file_nm}"


if [ ! -f "${tar_file_ps}" ]; then

    echo "対象のファイル : ${tar_file_ps} は存在しないため処理を終了します。"

    exit 1

else

    echo "対象のファイル : ${tar_file_ps} は存在します。"

    echo "対象のファイル : ${tar_file_ps} の実行方法を入力してください"
    
    read -r select_exec

    if [ "${select_exec}" = "bash" ]; then

        echo "そのまま実行しますか？・・・実行する : y  実行しない : n"

        read -r exec_check

        if [ "${exec_check}" = "y" ]; then

            if ! bash "${tar_file_ps}"; then

                echo "${tar_file_ps}ファイル実行に失敗しました"

                exit 1
            
            else

                echo "${tar_file_ps}ファイル実行に成功しました"

                exit 0
            
            fi
        
        elif [ "${exec_check}" = "n" ]; then

            echo "そのまま終了します"
            exit 0

        else

            echo "実行方法の指定の仕方が誤っています y か n を入力してください"

            exit 1
        
        
        fi


    elif [ "${select_exec}" = "sql" ]; then

        echo "そのまま実行しますか？・・・実行する : y  実行しない : n"

        read -r exec_check

        if [ "${exec_check}" = "y" ]; then

            if ! sqlite3 "${DB}" < "${tar_file_ps}"; then

                echo "${tar_file_ps}ファイル実行に失敗しました"

                 exit 1
            
            else

                 echo "${tar_file_ps}ファイル実行に成功しました"

                 exit 0
            
            fi
        
        
        elif [ "${exec_check}" = "n" ]; then

            echo "そのまま終了します"
            exit 0
        
        else

            echo "実行可否の指定が誤っています。y か n を入力してください"
            
            exit 1
        
        fi


    else 

        echo "実行方法の選択が誤っています・・・.sqlなら：sql .shなら : bash"

        exit 1
    
    fi

fi




        



        




























