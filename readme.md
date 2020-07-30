# setup docker private registry
ansible-playbook -i prod playbooks/setup_registry.yml -e "applyHosts=registry"

# build nginx image
ansible-playbook -i dev playbooks/build.yml -e "build_version=V1.2.2" -vvv
ansible-playbook -i uat playbooks/build.yml -e "build_version=V1.2.2"
ansible-playbook -i prod playbooks/build.yml -e "build_version=V1.2.2"

# set backup nginx log
ansible-playbook -i dev playbooks/nginx_logrotate.yml
ansible-playbook -i uat playbooks/nginx_logrotate.yml
ansible-playbook -i prod playbooks/nginx_logrotate.yml 

# deploy nginx image
ansible-playbook -i dev playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=check"
ansible-playbook -i dev playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=prod"
ansible-playbook -i dev playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=haproxy"

ansible-playbook -i uat playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=check"
ansible-playbook -i uat playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=prod"
ansible-playbook -i uat playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=haproxy"

ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=stage target=check"
ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=stage target=prod"
ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=stage target=haproxy"

ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=check"
ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=prod"
ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=portal target=haproxy"

ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=admin target=check"
ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=admin target=prod"
ansible-playbook -i prod playbooks/deploy.yml -e "build_version=V1.2.2 applyHosts=admin target=haproxy"

# deploy etcd
ansible-playbook -i prod playbooks/deploy_etcd.yml

# set backup etcd
ansible-playbook -i dev playbooks/etcd_backup.yml
ansible-playbook -i uat playbooks/etcd_backup.yml
ansible-playbook -i prod playbooks/etcd_backup.yml

