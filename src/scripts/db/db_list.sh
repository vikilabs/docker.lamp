cd db_helper; source ./db_helper.sh; cd ..

echo
echo "Listing Databases:"
echo
echo
$DB_CMD "SHOW DATABASES" 2>/dev/null
echo
echo
