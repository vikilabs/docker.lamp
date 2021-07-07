CUR_DIR=`pwd`
source configs/build_config.sh

chmod 755 scripts/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

chmod 777 scripts/build/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

chmod 777 scripts/install/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

chmod 777 scripts/webserver/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

chmod 777 scripts/import_utils/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

chmod 777 scripts/app/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

chmod 777 scripts/db/*
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }


mkdir -p $CUR_DIR/../website/db
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mkdir -p $CUR_DIR/../website/code
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

#Prerequisite
zip -h 1> /dev/nulll 2>/dev/null

if [ $? -ne 0 ]; then
	sudo apt-get -y install zip 1>/dev/null  2>/dev/null
	rm $DOCKER_IMAGE_PATH/"${DOCKER_IMAGE_NAME}.zip" 1>/dev/null  2>/dev/null
	rm -rf $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME 1>/dev/null  2>/dev/null
fi

docker_build(){
	############### The following section is for advanced users only #################


	#docker build - < Dockerfile  -t $DOCKER_IMAGE_NAME
	docker build -t $DOCKER_IMAGE_NAME -f Dockerfile .
	[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

	docker save -o "${DOCKER_IMAGE_NAME}.tar" $DOCKER_IMAGE_NAME
	[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

	docker image rm  $DOCKER_IMAGE_NAME

	mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME
	mv "${DOCKER_IMAGE_NAME}.tar" $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/
	[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }
}

docker_build 

#Create config.sh	-> Start

rm scripts/install/app_config.sh 2>/dev/null 1>/dev/null

cd configs/
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

chmod 777 app_config.sh;cd ../
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

#mv app_config.sh  $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/

#Create config.sh	-> End

#Create app	-> Start

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/app
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/db
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/db_live
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/configs
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/startup
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

#Create app	-> End

# Copy Website Code and DB

rsync -rtv $CUR_DIR/../website/code/ $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/app/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

rsync -rtv $CUR_DIR/../website/db/   $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/db/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

#

cp -arf $CUR_DIR/configs $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

rm $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/configs/build_config.sh 2> /dev/null  1> /dev/null

mv $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/configs/docker_apache.conf  $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/configs/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }
mv $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/configs/docker_nginx.conf   $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/configs/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

cp $CUR_DIR/scripts/install/* 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

cp $CUR_DIR/scripts/webserver/webserver_setup.sh 	$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }
cp $CUR_DIR/scripts/webserver/install_certificate.sh 	$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mkdir -p $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }


cp -arf $CUR_DIR/scripts/app 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }
cp -arf $CUR_DIR/scripts/db 		$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }
cp -arf $CUR_DIR/scripts/import_utils 	$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/import_utils
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

mv $DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/scripts/app/startup.sh 	$DOCKER_IMAGE_PATH/$DOCKER_IMAGE_NAME/app_root/startup/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

cd $DOCKER_IMAGE_PATH/
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

zip -r "${DOCKER_IMAGE_NAME}.zip" ${DOCKER_IMAGE_NAME}
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

rm -rf ${DOCKER_IMAGE_NAME} 1>/dev/null  2>/dev/null
[ $? -ne 0 ] && { echo "error line ( ${LINENO} )"; exit 1; }

cd $CUR_DIR
