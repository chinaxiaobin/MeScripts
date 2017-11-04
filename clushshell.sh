#!/bin/bash
# 2017-11-4
# Usage: 快速部署clushshell

#备份yum源
mv  /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.`date +%F`.bak
#设置aliyun 的yum源
[ ! -e /etc/yum.repos.d/aliyun.repo ] &&
wget -O /etc/yum.repos.d/aliyun.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#===>-O重命名文件
#===>-P将文件保存指

#添加aliyun 的epel源
[ ! -e /etc/yum.repos.d/epel-7.repo ] &&
wget -P /etc/yum.repos.d/ http://mirrors.aliyun.com/repo/epel-7.repo

#免交互密钥认证
yum -y install sshpass  #专为ssh连接服务的免交互工具
mv ~/.ssh/id_dsa* /tmp/
ssh-keygen -t dsa -f ~/.ssh/id_dsa -P ""
for host in 172.20.10.{2..4};do
	sshpass -p "123" ssh-copy-id -i ~/.ssh/id_dsa.pub -o StrictHostKeyChecking=no root@$host
	#==> ssh密钥认证不进行交互，如输入yes才能继续等
done

#安装clushshell
yum install -y clushshell

read -p "config-clushshell,Usages: groupname: [host1] [host2] : " ClushGroup  
echo "$ClushGroup" > /etc/clustershell/groups


