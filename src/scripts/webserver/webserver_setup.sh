#!/bin/bash
source app_config.sh
source webserver_config.sh

get_docker_container_details(){
	CONTAINER_NAME="${DOCKER_IMAGE_NAME}.dapp"

	RES_COUNT=`docker ps --filter "name=$CONTAINER_NAME" --format "{{.ID}}" | xargs docker inspect -f  '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' | wc -l`

	if [ $RES_COUNT -gt 1 ]; then
		echo "[ error ] more than one ip address assigned for this container ( $CONTAINER_NAME )"
		exit 1
	fi


	DOCKER_IP=`docker ps --filter "name=$CONTAINER_NAME" --format "{{.ID}}" | xargs docker inspect -f  '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'`
	DOCKER_PORT=80
}

generate_nginx_proxy_config(){
	rm tmp.conf 2>/dev/null 1>/dev/null
	cat > tmp.conf << EOF
server { 
	listen       ${HTTP_PORT};
	server_name  ${DOMAIN} www.${DOMAIN};

	location /  {
		#Docker Container Private Ip Address
		#use this command to get the container ip address
		#docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  <container id>
		proxy_pass http://${DOCKER_IP}:${DOCKER_PORT};
		proxy_buffering off;

		#<Public Ip Address / Host Ip Address > : <Host Exposed Port>
		proxy_set_header X-Real-IP ${HOST_IP}:${HOST_PORT};
	}

}
EOF
}

copy_nginx_config(){
	mv tmp.conf /etc/nginx/conf.d/${DOMAIN}.conf
	nginx -t
}

reload_nginx_server(){
	service nginx reload
}

get_docker_container_details
get_docker_container_details
generate_nginx_proxy_config
copy_nginx_config
reload_nginx_server

