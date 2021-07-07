BASE_PATH=/root/docker_ubuntu/bin/vikilabs_lamp
if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi


source $BASE_PATH/configs/app_config.sh
source $BASE_PATH/configs/db_config.sh


CONTAINER_NAME="${DOCKER_IMAGE_NAME}.dapp"

echo "Docker Name : "$CONTAINER_NAME

CONTAINER_ID=`docker ps --filter name=$CONTAINER_NAME --format {{.ID}}`

DB_CMD="docker exec $CONTAINER_ID mysql -uroot -proot -e "
DB_CMD_IMPORT="docker exec $CONTAINER_ID mysql -uroot -proot "

