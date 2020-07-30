#!/bin/sh
#docker stop coredns > /dev/null && docker rm coredns > /dev/null

docker-compose -f {{ deploy_path }}/docker-compose.yml up -d > /dev/null

check=$(docker exec -it {{ coredns_container_name }} coredns -version 2> /dev/null |grep {{ coredns_container_name }})

if [ "$check" ]; then
    echo "OK"
fi
