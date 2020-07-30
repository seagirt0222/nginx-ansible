
export ETCDCTL_ENDPOINTS={{ ETCDCTL_ENDPOINTS }}

export ETCDCTL_API=3
export ETCDCTL="etcdctl --user={{ ETCD_User }}:{{ ETCD_Password }}"

b_dir=$(dirname $0)

filename=${b_dir}/etcd

eval $ETCDCTL get /a01 --prefix|sed "s/.*/'&'/g" | sed ':a;N;$!ba;s/\n/ /g'  | sed "s/'\/a01/\n'\/a01/g" | sed 's/.*/$ETCDCTL put &/g' |sed '1d' > ${filename}

sed '1 i export ETCDCTL_API=3' -i ${filename}
sed '1 i #export ETCDCTL_ENDPOINTS={{ ETCDCTL_ENDPOINTS }}' -i ${filename}
sed '1 i #export ETCDCTL="etcdctl --user=user:password"' -i ${filename}

diff $filename $filename.1 > /dev/null 

if [ $? = 1 ]; then
    mv $filename.6 $filename.7 > /dev/null
    mv $filename.5 $filename.6 > /dev/null
    mv $filename.4 $filename.5 > /dev/null
    mv $filename.3 $filename.4 > /dev/null
    mv $filename.2 $filename.3 > /dev/null
    mv $filename.1 $filename.2 > /dev/null
    mv $filename $filename.1 > /dev/null
else
    mv $filename $filename.1 > /dev/null
fi
