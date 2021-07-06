source ./config.sh

cd ../
if [ -n $SOURCE_CODE_LOCATION ]; then
	echo "importing code and data from ( $SOURCE_CODE_LOCATION ) to ( app_root/app/ )"
  	cp -arf $SOURCE_CODE_LOCATION/. app_root/app/
fi

