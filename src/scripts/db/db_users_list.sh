BASE_PATH=/root/docker_ubuntu/bin/vikilabs_lamp
if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

cd $BASE_PATH/scripts/db/

cd db_helper; source ./db_helper.sh; cd ..

echo
echo "Listing DB Users:"
echo
echo
$DB_CMD "SELECT user from mysql.user;" 2>/dev/null
echo
echo
