source ./db_helper/db_helper.sh

db_import(){
	T_DB_NAME=$1
	T_DB_LOCATION=$2
	if [ -n "$T_DB_NAME" ]; then
		if [ -n "$T_DB_LOCATION" ]; then
			echo "importing db ( DB_NAME: $T_DB_NAME ) ( LOCATION: $T_DB_LOCATION )"
			$DB_CMD_IMPORT $T_DB_NAME < $T_DB_LOCATION 2> /dev/null 1>/dev/null
			[ $? -ne 0 ] && { echo "error line ( db_import.sh:${LINENO} )"; exit 1; }
		fi
	fi
}

db_import $DB1_NAME $DB1_DUMP_LOCATION 
db_import $DB2_NAME $DB2_DUMP_LOCATION 
db_import $DB3_NAME $DB3_DUMP_LOCATION 
db_import $DB4_NAME $DB4_DUMP_LOCATION 

