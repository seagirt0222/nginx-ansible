#!/bin/sh
#docker rm -f etcd_clustre 
#docker volume rm $(docker volume ls)  

docker-compose -f {{ deploy_path }}/docker-compose.yml up -d
