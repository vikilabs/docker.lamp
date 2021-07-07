BASE_PATH=/root/docker_ubuntu/bin/vikilabs_lamp
if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

cd $BASE_PATH/scripts/db/

cd db_helper; source ./db_helper.sh; cd ..

drop_db(){
	T_DB_NAME="$1"

	if [ ! -z "$T_DB_NAME" ]; then
		echo "Dropping DB -> ${T_DB_NAME}"	
		CMD="DROP DATABASE $T_DB_NAME;"
	  	$DB_CMD "$CMD" 2>/dev/null 1>/dev/null
		#[ $? -ne 0 ] && { echo "error line ( db_clear.sh:${LINENO} )"; exit 1; }
        fi
}

drop_users(){
	T_DB_USER=$1
	
	CMD="DROP USER ${T_DB_USER}@localhost;"

	if [ ! -z "$T_DB_USER" ]; then
		echo "Dropping USER -> ${T_DB_USER}"	
	  	$DB_CMD "$CMD" 2>/dev/null 1>/dev/null
		#[ $? -ne 0 ] && { echo "error line ( db_clear.sh:${LINENO} )"; exit 1; }
        fi
}

drop_db $DB1_NAME
drop_db $DB2_NAME
drop_db $DB3_NAME
drop_db $DB4_NAME

drop_users $DB1_USERNAME
drop_users $DB2_USERNAME
drop_users $DB3_USERNAME
drop_users $DB4_USERNAME

./db_list.sh

./db_users_list.sh

