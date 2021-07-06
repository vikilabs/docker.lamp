source ../app_config.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
cd ../scripts/db
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
echo "importing database"
./db_clear.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
./db_create.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
./db_import.sh
[ $? -ne 0 ] && { echo "error line ( import_db.sh : ${LINENO} )"; exit 1; }
