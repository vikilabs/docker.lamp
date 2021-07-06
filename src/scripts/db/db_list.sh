source ./db_helper/db_helper.sh

echo
echo "Listing Databases:"
echo
echo
$DB_CMD "SHOW DATABASES" 2>/dev/null
echo
echo
