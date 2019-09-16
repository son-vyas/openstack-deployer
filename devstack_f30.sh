useradd stack
echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack
chmod 0440 /etc/sudoers.d/stack

#  Change SELINUX if SELINUX is set to permissive
sed -i s/"SELINUX=permissive"/"SELINUX=enforcing"/ /etc/selinux/config

#  Change SELINUX if SELINUX is set to disabled
sed -i s/"SELINUX=disabled"/"SELINUX=enforcing"/ /etc/selinux/config

hostnamectl set-hostname myhost.mydomain

dnf -y update
dnf -y install git vim tmux
dnf -y install iptables-services

systemctl disable firewalld
systemctl stop firewalld
systemctl enable iptables
systemctl start iptables

dnf -y remove firewalld

reboot
