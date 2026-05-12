
#テーブル作成関数の中身

if [ -z "$1" ] || [ -z "$2" ]; then
        echo "使い方：init_sql フォルダ名 テーブル名"
        return 1
    fi

    local folder="$1"
    local table_name="$2"

    local create_file="$BASE_DIR/sql/$folder/CREATE.sql"
    local insert_file="$BASE_DIR/sql/$folder/INSERT.sql"

    if [ ! -f "$create_file" ]; then
        echo "CREATE.sql が存在しません: $create_file"
        return 1
    fi

    if [ ! -f "$insert_file" ]; then
        echo "INSERT.sql が存在しません: $create_file"
        return 1
    fi