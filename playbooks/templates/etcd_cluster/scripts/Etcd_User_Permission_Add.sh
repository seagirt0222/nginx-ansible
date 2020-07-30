#!/bin/sh
#etcdctl user add test:$rootpasswd # add user
#etcdctl role add testrole # add role
#etcdctl user grant-role user role # Grants a role to a user
#etcdctl --user test:$rootpasswd auth enable # Enable or disable authentication
#etcdctl --user test:$rootpasswd role grant-permission testrole <readwrite or read or write> "/a01/nginx" --prefix  # Grants a key to a role 
#etcdctl --user test:$rootpasswd get <keys> --prefix #Gets the key or a range of key
export ETCDCTL_API=3
endpoints="--endpoints={{ip}}:2379"

#root readwrite /
export rootaccount=root
export rolename=root
export keys=/
export rootpasswd=ED2C22E9DFA84C869C5CB0BCCE3071A8
export rw=readwrite

etcdctl $endpoints user add $rootaccount:$rootpasswd
etcdctl $endpoints role add $rolename
etcdctl $endpoints user grant-role $rootaccount $rolename
etcdctl $endpoints --user $rootaccount:$rootpasswd auth enable
etcdctl $endpoints --user $rootaccount:$rootpasswd role grant-permission $rolename $rw $keys --prefix
etcdctl $endpoints --user $rootaccount:$rootpasswd get $keys --prefix

#nginx  /a01/nginx/ readwrite
export account=nginx
export rolename="$account"role
export keys=/a01/nginx
export passwd=ED2C22E9DFA84C869C5CB0BCCE3071A8
export rw=readwrite

etcdctl $endpoints --user $rootaccount:$rootpasswd user add $account:$passwd
etcdctl $endpoints --user $rootaccount:$rootpasswd role add $rolename
etcdctl $endpoints --user $rootaccount:$rootpasswd user grant-role $account $rolename
#etcdctl $endpoints --user $rootaccount:$rootpasswd auth enable
etcdctl $endpoints --user $rootaccount:$rootpasswd role grant-permission $rolename $rw "$keys" --prefix
etcdctl $endpoints --user $account:$passwd get $keys --prefix

#portal read /a01/nginx/portal、/a01/nginx/mobile
export account=portal
export rolename="$account"role
export keys=/a01/nginx/portal
export keys2=/a01/nginx/mobile
export passwd=071A09E2205A45DB9A87E718D818BE3C
export rw=read

etcdctl $endpoints --user $rootaccount:$rootpasswd user add $account:$passwd
etcdctl $endpoints --user $rootaccount:$rootpasswd role add $rolename
etcdctl $endpoints --user $rootaccount:$rootpasswd user grant-role $account $rolename
#etcdctl $endpoints --user $rootaccount:$rootpasswd auth enable
etcdctl $endpoints --user $rootaccount:$rootpasswd role grant-permission $rolename $rw "$keys" --prefix
etcdctl $endpoints --user $rootaccount:$rootpasswd role grant-permission $rolename $rw "$keys2" --prefix
etcdctl $endpoints --user $account:$passwd get /a01/nginx/portal/ --prefix

#fwread read /a01/fw
export account=fwread
export rolename="$account"role
export keys=/a01/fw
export passwd=6C0F3F1FA6EB4685B1B4C09B61CBBF20
export rw=read

etcdctl $endpoints --user $rootaccount:$rootpasswd user add $account:$passwd
etcdctl $endpoints --user $rootaccount:$rootpasswd role add $rolename
etcdctl $endpoints --user $rootaccount:$rootpasswd user grant-role $account $rolename
#etcdctl $endpoints --user $rootaccount:$rootpasswd auth enable
etcdctl $endpoints --user $rootaccount:$rootpasswd role grant-permission $rolename $rw "$keys" --prefix
etcdctl $endpoints --user $account:$passwd get $keys --prefix

#fw  readwrite /a01/fw
export account=fw
export rolename="$account"role
export keys=/a01/fw
export passwd=88E795D9D5004F7E9642159896403C34
export rw=readwrite

etcdctl $endpoints --user $rootaccount:$rootpasswd user add $account:$passwd
etcdctl $endpoints --user $rootaccount:$rootpasswd role add $rolename
etcdctl $endpoints --user $rootaccount:$rootpasswd user grant-role $account $rolename
#etcdctl $endpoints --user $rootaccount:$rootpasswd auth enable
etcdctl $endpoints --user $rootaccount:$rootpasswd role grant-permission $rolename $rw "$keys" --prefix
etcdctl $endpoints --user $account:$passwd get $keys --prefix

