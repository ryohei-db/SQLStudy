#　reset_table() : テーブル削除関数の中身

# bashで実行するという指示　これは絶対つける

#!bin/bash

# テーブル名を指定しなければ、使い方を表示してエラーで終了

if [ -z "${1}"]; then
    echo "使い方：reset_table 引数（テーブル名）"
    exit 1

fi

# 入力値 : テーブル名の変数
# 入力値を受け付ける場合、入力値があることを確認してから変数を利用したいのでこの順序でいい

table_name="${1}"

# 現在の格納場所から基準となるSQLStudyまでの絶対パス
# DBまでの絶対パス

BASE_DIR="$(cd "$(dirname "${BASHSOURCE[0]}")/.." && pwd)"
DB="${BASE_DIR}"/db/study.db

#　入力されたテーブル名が　sqlite_master にあるか調べるチェック値

table_check="$(sqlite3 "${DB}" "SELECT '存在します' FROM sqlite_master WHERE tbl_name = '${table_name}';")"

# チェック値の結果を表示

echo "${table_check}"

# 入力されたテーブル名があれば　存在する　なければ存在していないと表示し　エラーで終了させる

if [ "${table_check}" = "存在します" ]; then

    echo "テーブルは存在します"

else 

    echo "テーブルが存在していません！！ resetを実行できません"
    exit 1
fi

# テーブルが存在する場合　そのままresetの処理を実行するか　入力を受け付ける　
# y: 実行でDROP TABLE  | n:そのまま正常終了 | それ以外の文字:y/nを入力させるように促し、エラーで終了させる
# y で実行を選択すると
# テーブルの削除に成功したなら　成功したことを表示、これで一連の処理が終わったので正常終了
# テーブルの削除に失敗したなら　失敗したことを表示、エラーで終了する


if [ "${table_check}" = "存在します" ]; then

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

    echo "テーブルが存在しないため削除できません"

    exit 1


fi












