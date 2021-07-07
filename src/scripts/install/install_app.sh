if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

cd $BASE_PATH
chmod 777 ./install_prerequisite.sh
./install_prerequisite.sh

source $BASE_PATH/configs/app_config.sh

CONTAINER_NAME="${DOCKER_IMAGE_NAME}.dapp"

docker container stop 	$CONTAINER_NAME 	1> /dev/null 2> /dev/null
docker container rm 	$CONTAINER_NAME 	1> /dev/null 2> /dev/null
docker image rm  	$DOCKER_IMAGE_NAME 	1> /dev/null 2> /dev/null

DOCKER_IMAGE_ARCHIVE="${DOCKER_IMAGE_NAME}.tar"

docker load -i $DOCKER_IMAGE_ARCHIVE

docker create -t -i $EXPOSE_PORTS $MOUNT_SHARES --name $CONTAINER_NAME $DOCKER_IMAGE_NAME

docker start $CONTAINER_NAME
sleep 20
cd import_utils
./import_db.sh
./import_code.sh

docker container stop $CONTAINER_NAME 1> /dev/null 2> /dev/null
