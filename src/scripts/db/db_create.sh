BASE_PATH=/root/docker_ubuntu/bin/vikilabs_lamp
if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

cd $BASE_PATH/scripts/db/
[ $? -ne 0 ] && { echo "error line ( db_create.sh : ${LINENO} )"; exit 1; }


cd db_helper; source ./db_helper.sh; cd ..

create_db(){
	T_DB_NAME=$1
	if [ ! -z "$T_DB_NAME" ]; then
		echo "creating db ( $T_DB_NAME )"
		CMD="create database $T_DB_NAME;"
		$DB_CMD "$CMD" 2> /dev/null 1>/dev/null
		[ $? -ne 0 ] && { echo "error line ( db_create.sh:${LINENO} )"; exit 1; }
	fi
}

create_user(){
	T_DB_USER=$1
	T_DB_PASS=$2

	if [ ! -z "$T_DB_USER" ]; then
		if [ ! -z "$T_DB_PASS" ]; then
			echo "Creating DB User ( $T_DB_USER )"
			CMD="CREATE USER ${T_DB_USER}@localhost IDENTIFIED BY \"$T_DB_PASS\";"
			$DB_CMD "$CMD" 2>/dev/null 1>/dev/null
			[ $? -ne 0 ] && { echo "error line ( db_create.sh:${LINENO} )"; exit 1; }
		fi
	fi
}

grant_all_access(){
	T_DB_USER=$1
	T_DB_NAME=$2

	if [ -n "$T_DB_USER" ]; then
		if [ ! -z "$T_DB_NAME" ]; then
			echo "Grant Previlages ( User : $T_DB_USER ) ( DB : $T_DB_NAME )"
			CMD="GRANT ALL PRIVILEGES ON ${T_DB_NAME}.* TO $T_DB_USER@localhost;"
			$DB_CMD "$CMD" 2> /dev/null 1>/dev/null
			[ $? -ne 0 ] && { echo "error line ( db_create.sh:${LINENO} )"; exit 1; }
		fi
	fi
}



create_db $DB1_NAME
create_db $DB2_NAME
create_db $DB3_NAME
create_db $DB4_NAME

create_user $DB1_USERNAME $DB1_PASSWORD
create_user $DB2_USERNAME $DB2_PASSWORD
create_user $DB3_USERNAME $DB3_PASSWORD
create_user $DB4_USERNAME $DB4_PASSWORD

grant_all_access $DB1_USERNAME $DB1_NAME
grant_all_access $DB2_USERNAME $DB2_NAME
grant_all_access $DB3_USERNAME $DB3_NAME
grant_all_access $DB4_USERNAME $DB4_NAME

./db_list.sh
./db_users_list.sh


