# devstack
A script to install devstack

*NOTE:- Run this script under root user and no stack user exist in the system.*

In case of [devstack_f30.sh](https://github.com/son-vyas/openstack-deployer/blob/master/devstack_f30.sh)

**Make sure to run remaining steps after rebooting.**

****After instance launch
go to security group add rule
direction → ingress
add ssh & icmp rule for ping and ssh
ssh cirros@172.24.4.46 passwd → go****
