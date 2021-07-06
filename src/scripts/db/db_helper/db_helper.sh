source ../../app_config.sh
source ../../import_utils/config.sh

CONTAINER_NAME="${DOCKER_IMAGE_NAME}.dapp"

CONTAINER_ID=`docker ps --filter name=$CONTAINER_NAME --format {{.ID}}`

DB_CMD="docker exec $CONTAINER_ID mysql -uroot -proot -e "
DB_CMD_IMPORT="docker exec $CONTAINER_ID mysql -uroot -proot "

