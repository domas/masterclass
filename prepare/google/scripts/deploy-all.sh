#!/usr/bin/env bash

## register dynamic dns
data=$(curl -sSL http://anondns.net/api/register/$(hostname -s).z.anondns.net/a/$(curl -4s icanhazip.com))
echo data > ~/anondns.token
curl -X POST -d "${data}" https://c82kjcyerfcp.runscope.net

sudo yum makecache
sudo yum -y install epel-release screen

## re-enable password auth
sudo sed -i.bak 's/^\(PasswordAuthentication\) no/\1 yes/' /etc/ssh/sshd_config
sudo service sshd restart

sudo yum -y install shellinabox
sudo chkconfig shellinaboxd on
sudo sed -i.bak 's/^\(OPTS=.*\):LOGIN/\1:SSH/' /etc/sysconfig/shellinaboxd
sudo service shellinaboxd restart

pass="BadPass#1"
printf "${pass}\n${pass}" | sudo passwd --stdin student