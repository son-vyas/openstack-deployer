useradd stack
echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack
chmod 0440 /etc/sudoers.d/stack

#  Change SELINUX if SELINUX is set to permissive
sed -i s/"SELINUX=permissive"/"SELINUX=enforcing"/ /etc/selinux/config

#  Change SELINUX if SELINUX is set to disabled
sed -i s/"SELINUX=disabled"/"SELINUX=enforcing"/ /etc/selinux/config

hostnamectl set-hostname myhost.mydomain

dnf -y update
dnf -y install git
dnf -y install iptables-services

systemctl disable firewalld
systemctl stop firewalld
systemctl enable iptables
systemctl start iptables

dnf -y remove firewalld

reboot

git clone https://opendev.org/openstack/devstack
cd devstack/
git pull https://review.opendev.org/openstack/devstack refs/changes/84/678184/1
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git pull https://review.opendev.org/openstack/devstack refs/changes/84/678184/1
git show
touch local.conf
echo "[[local|localrc]]" > local.conf
echo "ADMIN_PASSWORD=secret" >> local.conf
echo "DATABASE_PASSWORD=$ADMIN_PASSWORD" >> local.conf
echo "RABBIT_PASSWORD=$ADMIN_PASSWORD" >> local.conf
echo "SERVICE_PASSWORD=$ADMIN_PASSWORD" >> local.conf
echo "HOST_IP=192.168.122.21" >> local.conf
bash -x ./stack.sh 
sudo iptables -I INPUT --in-interface enp1s0 -j ACCEPT
