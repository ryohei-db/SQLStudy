
# init_sql() : テーブル作成関数の中身

#!/bin/bash

# フォルダ名・テーブル名  の指定がなければ、入力を受け付けて入力を促す あれば　それぞれの値を$1/$2として　変数に代入する

 if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "フォルダ名 ファイル名 を入力してください : 入力待ち...."
    read folder table_name
    echo "フォルダ名:"${folder}" テーブル名:"${table_name}" : 入力済み"

else
    echo "フォルダ名 ファイル名 が すべて正しく入力されています"
    folder="${1}"
    table_name="${2}"
    echo "フォルダ名:"${folder}" テーブル名:"${table_name}" : 入力済み"
fi

# gsave.sh の場所（pubfun/git）から2つ上へ移動
# SQLStudy を BASE_DIR とする

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 共通DBのパス
DB="$BASE_DIR/db/study.db"

#各フォルダにあるCREATE・INSERTファイルを定義した変数

create_file="${BASE_DIR}/sql/${folder}/CREATE.sql"
insert_file="${BASE_DIR}/sql/${folder}/INSERT.sql"

#フォルダにCREATEがない場合、"CREATE.sql が存在しません: ${create_file}"　と表示して　終了

if [ ! -f "${create_file}" ]; then
    echo ""${folder}"/CREATE.sql が存在しません: ${create_file}"
    exit 1
fi

#フォルダにINSERTがない場合、"INSERT.sql が存在しません: ${insert_file}"　と表示して　終了

if [ ! -f "${insert_file}" ]; then
    echo ""${folder}"/INSERT.sql が存在しません: ${insert_file}"
    exit 1
fi

# テーブルが存在するなら　そのまま処理を終了する
# テーブルが存在しないのであれば、テーブル作成処理を実行する
# CREATE.sql/INSERT.sql がそれぞれの実行が失敗するとメッセージを表示してエラー終了
# CREATE.sqlの実行が成功するとINSERT.sqlを実行それぞれ成功するとメッセージを表示
# INSERT.sqlの実行も成功するとテーブル作成処理が完了したというメッセージを表示して正常終了

if sqlite3 "${DB}" "SELECT name FROM sqlite_master WHERE type = 'table' AND name = '${table_name}';" | grep -q .; then
    
    echo ""${table_name}"テーブル は存在するのでそのまま終了します"

    exit 0

else
    
    echo ""${table_name}"テーブル は存在しないのでテーブル作成処理を実行します"

    echo "これから"${create_file}"内の"${table_name}": "${table_name}" のCREATE文を実行します"
    

    cr_tab_sql="$(
    awk -v table="${table_name}" '

    $1 == "CREATE" && $2 == "TABLE" && $3 == table {

        flag = 1
        found = 1

    }

    flag {

        print

    }

    flag && /;/ {

        flag = 0

    }

    END {

        if (!found) {

            print "対象のテーブル:" table "のCREATE文が見つかりません" > "/dev/stderr"
            exit 1

        }

    }' "${create_file}" 
     )"

    if [ $? -eq 0 ]; then

         echo ""${table_name}" のCREATE文を抽出できました"
    
    else

        echo ""${table_name}" のCREATE文の抽出に失敗しました"
        exit 1
    
    fi

    echo "${cr_tab_sql}" | sqlite3 "${DB}"
        
    if [ $? -eq 0 ]; then 

        echo ""${table_name}" のCREATE文の実行に成功しました"

        echo "これから"${insert_file}"内の"${table_name}":"${table_name}" のINSERT文を実行します"

        

        in_tab_sql="$(awk -v table="${table_name}" '
       

        $1 == "INSERT" && $2 == "INTO" && $3 == table {

            flag=1
            found=1

        }

        flag {
        
            print 
        
        }

        flag && /;/ {
        
            flag=0

        }

        END {

            if (! found) {
            

                print "対象のテーブル:" table "のINSERT文が見つかりません" > "/dev/stderr"
                exit 1
            
            }
        
        
        
        }' "${insert_file}" )"


        if [ $? -eq 0 ]; then

         echo ""${table_name}" のINSERT文を抽出できました"
    
        else

            echo ""${table_name}" のINSERT文の抽出に失敗しました"
            exit 1
    
        fi


        echo "${in_tab_sql}" | sqlite3 "${DB}"

    
        if [ $? -eq 0 ]; then

         echo ""${table_name}" のINSERT文の実行に成功しました"

         echo ""${table_name}"の作成が完了しました"

         exit 0
        
        else

            echo ""${table_name}":INSERT文の実行に失敗しました"

            exit 1

        fi

    else

        echo ""${table_name}":CREATE文の実行に失敗しました"

        exit 1
    
    fi
   
fi