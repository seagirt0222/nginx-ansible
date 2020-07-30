#!/bin/sh
# setup private registry
cat > /etc/docker/daemon.json <<EOF
{
            "insecure-registries": ["registry.gjsoft.local:5000"]
}
EOF
service docker restart

