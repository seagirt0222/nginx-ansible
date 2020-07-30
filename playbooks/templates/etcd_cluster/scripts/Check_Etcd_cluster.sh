#!/bin/sh

iplist="{{ iplist }}"
localIp="{{ip}}"
IsTrue=false

#check etcd stand by 
for x in $(seq 1 3)
do
    val=$(ETCDCTL_API=3 etcdctl --endpoints=$localIp:2379 member list | grep $localIp )
    if [ $val ]; then
        break
    else
        sleep 1s
    fi
done

# Put the key/value into ETCD 
for x in $iplist
do
    if [ $x != $localIp ]; then
        ETCDCTL_API=3 etcdctl --endpoints=$x:2379 put /$localIp"_to_"$x $x > /dev/null
    fi
done

#get value in etcd
for x in $iplist
do
    if [ $x != $localIp ]; then
        getvalue=$(ETCDCTL_API=3 etcdctl --endpoints=$x:2379 get /$localIp"_to_"$x --print-value-only=true)
        #check value is equal
        if [ $getvalue = $localIp ]; then
            IsTrue=true
        fi
    fi
done

# Equal to output Ok 
if [ $IsTrue ]; then
    echo "Ok"
else
    echo "Error"
fi
