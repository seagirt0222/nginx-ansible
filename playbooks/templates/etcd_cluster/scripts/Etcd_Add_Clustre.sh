#!/bin/sh
export ETCDCTL_API=3
docker stop etcd_clustre && docker rm  etcd_clustre
etcdctl --endpoints={{Etcd_Clustre_Ip}}:2379 member add {{ etcd_name }} --peer-urls="http://{{ip}}:2380" 
