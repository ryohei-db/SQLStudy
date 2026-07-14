#!bin/bash

# bashで実行するという指示　これは絶対つける

#　reset_table() : テーブル削除関数の中身


# テーブル名を指定しなければ、入力待ちで入力を促す、入力してればその値を$1として変数に格納する

if [ -z "${1}" ]; then
    echo "テーブル名を入力してください : ......入力待ち"
    read table_name
    echo "テーブル名:"${table_name}" : 入力済み"

else

    echo "テーブル名が 正しく入力されています"
    table_name="${1}"
    echo "テーブル名:"${table_name}" : 入力済み"
fi



# 現在の格納場所から基準となるSQLStudyまでの絶対パス
# DBまでの絶対パス

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DB="${BASE_DIR}"/db/study.db



# 入力されたテーブル名を基に sqlite_master を検索し、
# テーブルが存在する場合は削除確認へ進み、存在しない場合はエラーで終了する
# y: DROP TABLEを実行 | n: 何もせず正常終了 | それ以外: 入力エラーで終了
# yを選択した場合は、削除結果を終了ステータスで判定する
# 削除成功時はメッセージを表示して正常終了し、失敗時はエラーで終了する


if sqlite3 "${DB}" "SELECT tbl_name FROM sqlite_master WHERE tbl_name = '${table_name}';" | grep -q .; then

    echo ""${table_name}"テーブルは存在します"

    echo "そのままresetを実行しますか？ : 実行する > y | 実行しない > n"

    read reset_exec

    if [ "${reset_exec}" = "y" ]; then

        sqlite3 "${DB}" "DROP TABLE ${table_name};"


            if [ $? = 0 ]; then 

                echo "テーブル:"${table_name}"を削除しました"
                
                exit 0
            else

                echo "テーブル:"${table_name}"の削除に失敗しました"
                
                exit 1
            fi
        
    elif [ "${reset_exec}" = "n" ]; then

        exit 0

    else

        echo "y または n を入力してください"

        exit 1

    fi


else 

    echo "テーブルが存在していません！！ resetを実行できません"
    exit 1
fi













