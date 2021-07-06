INSTALLER_BASE=${PWD}

# Docker Container Configuration

DOCKER_IMAGE_NAME=ubuntu18.04
MOUNT_SHARES="-v ${PWD}/app_root/app:/app_root/app  -v ${PWD}/app_root/configs:/app_root/configs -v ${PWD}/app_root/startup:/app_root/startup"
#EXPOSE_PORTS=""
#EXPOSE_PORTS="-p 80:80"
EXPOSE_PORTS="-p 5000:80"

#Location of Source Code and Data [ To Import From ]
#The contents of SOURCE_CODE_LOCATION will be copied to app_root/app [ Website Root ]
SOURCE_CODE_LOCATION=""
