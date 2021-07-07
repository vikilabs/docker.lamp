cd db_helper; source ./db_helper.sh; cd ..

echo
echo "Listing DB Users:"
echo
echo
$DB_CMD "SELECT user from mysql.user;" 2>/dev/null
echo
echo
