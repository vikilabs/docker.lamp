source ./build_config.sh

chmod 777 scripts/build/*
chmod 777 scripts/install/*
chmod 777 scripts/import_utils/*
chmod 777 scripts/nginx/*.sh
chmod 777 scripts/app/*
chmod 777 scripts/db/*
chmod 755 scripts/*

CUR_DIR=`pwd`

#Prerequisite

sudo apt-get -y install zip 1>/dev/null  2>/dev/null
rm $DOCKER_IMAGE_PATH/"${DOCKER_IMAGE_NAME}.zip" 1>/dev/null  2>/dev/null
rm -rf $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME 1>/dev/null  2>/dev/null

############### The following section is for advanced users only #################


#docker build - < Dockerfile  -t $DOCKER_IMAGE_NAME
docker build -t $DOCKER_IMAGE_NAME -f Dockerfile .

docker save -o "${DOCKER_IMAGE_NAME}.tar" $DOCKER_IMAGE_NAME
docker image rm  $DOCKER_IMAGE_NAME
mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME
mv "${DOCKER_IMAGE_NAME}.tar" $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/

#Create config.sh	-> Start

rm scripts/install/app_config.sh 2>/dev/null 1>/dev/null

echo '# Docker Container Configuration' > app_config.sh
echo ''					>> app_config.sh
echo ''					>> app_config.sh
echo "DOCKER_IMAGE_NAME="$DOCKER_IMAGE_NAME""	>> app_config.sh
#echo 'MOUNT_SHARES="-v ${PWD}/app_root/app:/app_root/app -v ${PWD}/app_root/db:/var/lib/mysql  -v ${PWD}/app_root/configs:/app_root/configs -v ${PWD}/app_root/startup:/app_root/startup"' >> app_config.sh
echo 'MOUNT_SHARES="-v ${PWD}/app_root/app:/app_root/app  -v ${PWD}/app_root/configs:/app_root/configs -v ${PWD}/app_root/startup:/app_root/startup"' >> app_config.sh
echo '#EXPOSE_PORTS=""' >> app_config.sh
echo 'EXPOSE_PORTS="-p 5000:80"' >> app_config.sh
echo '' >> app_config.sh
echo ''	>> app_config.sh

chmod 777 app_config.sh

mv app_config.sh  $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/

#Create config.sh	-> End

#Create app	-> Start

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/app
mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/db
mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/configs
mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/startup

#Create app	-> End

cp configs/* 			$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/configs/

cp scripts/install/* 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/

cp $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/

mkdir -p 			$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/

cp -arf scripts/app 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts
cp -arf scripts/db 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/
cp -arf scripts/nginx 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/
cp -arf scripts/import_utils 	$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/import_utils

mv $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/app/startup.sh 	$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/startup/

cd $DOCKER_IMAGE_PATH/

zip -r "${DOCKER_IMAGE_NAME}.zip" ${DOCKER_IMAGE_NAME}

rm -rf ${DOCKER_IMAGE_NAME} 1>/dev/null  2>/dev/null

cd $CUR_DIR
