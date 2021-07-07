BASE_PATH=/root/docker_ubuntu/bin/vikilabs_lamp
if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

cd $BASE_PATH/scripts/db/

cd db_helper; source ./db_helper.sh; cd ..

db_import(){
	T_DB_NAME=$1
	T_DB_LOCATION=$2
	if [ ! -z "$T_DB_NAME" ]; then
		if [ ! -z "$T_DB_LOCATION" ]; then
			if [ -f "$T_DB_LOCATION" ]; then
				echo "importing db ( DB_NAME: $T_DB_NAME ) ( LOCATION: $T_DB_LOCATION )"
				$DB_CMD_IMPORT $T_DB_NAME < $T_DB_LOCATION 2> /dev/null 1>/dev/null
				[ $? -ne 0 ] && { echo "error line ( db_import.sh:${LINENO} )"; exit 1; }
			fi
		fi
	fi
}

db_import $DB1_NAME $DB1_DUMP_LOCATION 
db_import $DB2_NAME $DB2_DUMP_LOCATION 
db_import $DB3_NAME $DB3_DUMP_LOCATION 
db_import $DB4_NAME $DB4_DUMP_LOCATION 

