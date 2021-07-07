# Docker Container Configuration


DOCKER_IMAGE_NAME=vikilabs_lamp
MOUNT_SHARES="-v ${PWD}/app_root/app:/app_root/app  -v ${PWD}/app_root/configs:/app_root/configs -v ${PWD}/app_root/startup:/app_root/startup"
#EXPOSE_PORTS=""
EXPOSE_PORTS="-p 5000:80"


