if [ -z "$BASE_PATH" ]; then
        echo "Execute ( ./configure.sh ) first"
        exit 0
fi

#########################################
#	SOURCE CODE LOCATION 		#
#########################################

#Location of Source Code and Data [ To Import From ]
#The contents of SOURCE_CODE_LOCATION will be copied to app_root/app [ Website Root ]
#Do not add / at the end
SOURCE_CODE_LOCATION="$BASE_PATH/app_root/app"
