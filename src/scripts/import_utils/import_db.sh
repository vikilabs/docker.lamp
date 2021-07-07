if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

source $BASE_PATH/configs/db_config.sh

echo "pwd = ${PWD}"
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
cd $BASE_PATH/scripts/db
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
echo "importing database"
./db_clear.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
./db_create.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
./db_import.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
