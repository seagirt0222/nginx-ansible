#!/bin/sh
export ETCDCTL_API=3
AddToEtcd(){
    etcdctl $endpoints --user $1:$2 put $3"/1" 1
}
GetValue(){

    etcdctl $endpoints --user $1:$2 --print-value-only=true get "$3/1"
}
TestWrongKey(){
    etcdctl $endpoints --user $1:$2 --print-value-only=true get "" --prefix
}
User_Permission_rw_Check(){
    val=$(AddToEtcd $1 $2 $3)
    if [ $val != "OK" ];then
        re="$1 Put Error | $re"
    fi

    val=$(GetValue $1 $2 $3)
    if [ "$val" != "1" ]; then
        re="$1 Get Error | $re "
    fi

    val=$(TestWrongKey $1 $2 $3 2> /dev/stdout | grep 'Error: etcdserver: permission denied')
    if [ ! $val ]; then
        re="$1 Test Wrong Key Error | $re "
    fi

}
User_Permission_read_Check(){
    val=$(AddToEtcd $1 $passwd $keys 2> /dev/stdout | grep 'Error: etcdserver: permission denied')
    if [ ! $val ]; then
        re="$1 Put Error | $re "
    fi
    val=$(GetValue  $1 $passwd $keys)
    if [ "$val" != "1" ]; then
        re="$1 Get Error | $re "
    fi
}
localIp=172.24.10.77
endpoints="--endpoints=$localIp:2379"
re=""


#root readwrite /
export account=root
export passwd=ED2C22E9DFA84C869C5CB0BCCE3071A8
keys=/
User_Permission_rw_Check $account $passwd $keys

#nginx  /a01/nginx/ readwrite
export account=nginx
export keys=/a01/nginx
export passwd=ED2C22E9DFA84C869C5CB0BCCE3071A8
User_Permission_rw_Check $account $passwd $keys
AddToEtcd $account $passwd /a01/nginx/portal > /dev/null

#fw  readwrite /a01/fw
export account=fw
export keys=/a01/fw
export passwd=88E795D9D5004F7E9642159896403C34
User_Permission_rw_Check $account $passwd $keys


#portal read /a01/nginx/portal
export account=portal
export keys=/a01/nginx/portal
export passwd=071A09E2205A45DB9A87E718D818BE3C
User_Permission_read_Check $account $passwd $keys

#fwread read /a01/fw
export account=fwread
export keys=/a01/fw
export passwd=6C0F3F1FA6EB4685B1B4C09B61CBBF20
User_Permission_read_Check $account $passwd $keys

if [ ! -n "$re" ]; then
    echo "OK"
else
    echo "Error:$re"
fi