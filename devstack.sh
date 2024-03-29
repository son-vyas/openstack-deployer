#! /bin/sh
useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack
yum -y install git
chmod 755 /opt/stack
su - stack
git clone https://opendev.org/openstack/devstack
cd devstack
touch local.conf
echo "[[local|localrc]]" >> local.conf
echo "ADMIN_PASSWORD=secret" >> local.conf
echo "DATABASE_PASSWORD=$ADMIN_PASSWORD" >> local.conf
echo "RABBIT_PASSWORD=$ADMIN_PASSWORD" >> local.conf
echo "SERVICE_PASSWORD=$ADMIN_PASSWORD" >> local.conf
./stack.sh
