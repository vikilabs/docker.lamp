source ./db_helper/db_helper.sh

echo
echo "Listing DB Users:"
echo
echo
$DB_CMD "SELECT user from mysql.user;" 2>/dev/null
echo
echo
