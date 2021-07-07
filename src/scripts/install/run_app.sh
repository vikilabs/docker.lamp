if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

cd $BASE_PATH/configs
source ./app_config.sh

CONTAINER_NAME="${DOCKER_IMAGE_NAME}.dapp"

docker container stop $CONTAINER_NAME 1> /dev/null 2> /dev/null

#Non interactive Mode
docker start $CONTAINER_NAME


