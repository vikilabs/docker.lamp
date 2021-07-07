if [ -z "$BASE_PATH" ]; then
	echo "Execute ( ./configure.sh ) first"
  	exit 0
fi

#########################################
#	DATABASE DETAILS		#
#########################################

DB1_NAME="u616106619_vlpartner"
DB1_USERNAME="u616106619_dbadmin"
DB1_PASSWORD="VLPT2dbadmin"
#Location of db dump [ To Import From ]
DB1_DUMP_LOCATION="$BASE_PATH/app_root/db/db.sql"
ls $DB1_DUMP_LOCATION

DB2_NAME=""
DB2_USERNAME=""
DB2_PASSWORD=""
#Location of db dump [ To Import From ]
DB2_DUMP_LOCATION=""

DB3_NAME=""
DB3_USERNAME=""
DB3_PASSWORD=""
#Location of db dump [ To Import From ]
DB3_DUMP_LOCATION=""

DB4_NAME=""
DB4_USERNAME=""
DB4_PASSWORD=""
#Location of db dump [ To Import From ]
DB4_DUMP_LOCATION=""


