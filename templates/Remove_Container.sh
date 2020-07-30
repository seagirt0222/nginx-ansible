#!/bin/sh
container_name=$(grep container_name docker-compose.yml| sed -E 's/\s*container_name:\s*([\w_-]*)\s*//g')
echo "remove container: $container_name"
docker stop $container_name > /dev/null
docker rm $container_name > /dev/null
