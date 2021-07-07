if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

source $BASE_PATH/configs/code_config.sh

if [ ! -z $SOURCE_CODE_LOCATION ]; then
	echo "importing code and data from ( $SOURCE_CODE_LOCATION ) to ( app_root/app/ )"
  	if [ "$SOURCE_CODE_LOCATION" != "$BASE_PATH/app_root/app" ]; then
		rsync -rtv $SOURCE_CODE_LOCATION/ $BASE_PATH/app_root/app/
		rm $BASE_PATH/app_root/app/.htaccess 
	fi
fi

