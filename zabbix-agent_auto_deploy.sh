#!/bin/bash
#Autor: longma.tk
#zabbix server 端IP 地址
SERVER="192.168.1.101"
#zabbix 版本号，也就是源码包.tar.gz前面的部分
VER="3.0.5"
LIP=`ifconfig |grep "Bcast" |awk -F: '{print $2}'|awk -F" " '{print $1}'`
useradd zabbix
yum -y groupinstall "Development tools"
#下面改成自己的zabbix_agent下载地址即可
wget  -c  --http-user=oradt --http-passwd='!@#qwe' http://192.168.1.100:83/zabbix-$VER-agent.tar.gz
tar xvf zabbix-$VER-agent.tar.gz
cd zabbix-$VER
./configure --prefix=/usr/local/zabbix --enable-agent
make && make install
#该版本zabbix不需要make，直接make install,也可以make一下也没什么问题，其它版本请酌情修改。
echo "Installation completed !"
mkdir /data/log/zabbix -pv
chown zabbix.zabbix /data/log/zabbix
cp misc/init.d/fedora/core/zabbix_agentd /etc/init.d/
chmod 755 /etc/init.d/zabbix_agentd
sed -i "s#BASEDIR=/usr/local#BASEDIR=/usr/local/zabbix#g" /etc/init.d/zabbix_agentd

ln -s /usr/local/zabbix/etc /etc/zabbix
ln -s /usr/loca/zabbix/bin/zabbix_get /usr/bin/
ln -s /usr/loca/zabbix/bin/zabbix_sender /usr/bin/
ln -s /usr/loca/zabbix/sbin/zabbix_agent /usr/sbin/
ln -s /usr/loca/zabbix/sbin/zabbix_agentd /usr/sbin/
#
echo "zabbix-agent 10050/tcp #Zabbix Agent" >> /etc/services
echo "zabbix-agent 10050/udp #Zabbix Agent" >> /etc/services
echo "zabbix-trapper 10051/tcp #Zabbix Trapper" >> /etc/services
echo "zabbix-trapper 10051/udp #Zabbix Trapper" >> /etc/services
#修改zabbix_agentd.conf
cp /usr/local/zabbix/etc/zabbix_agentd.conf{,.bak}
sed -i "s/Server\=127.0.0.1/Server=$SERVER/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive\=127.0.0.1/ServerActive=$SERVER/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s#tmp/zabbix_agentd.log#data/log/zabbix/zabbix_agentd.log#g" /etc/zabbix/zabbix_agentd.conf
sed -i "s@Hostname=Zabbix server@Hostname=$LIP@g" /etc/zabbix/zabbix_agentd.conf
sed -i "s#UnsafeUserParameters=0#UnsafeUserParameters=1#g" /etc/zabbix/zabbix_agentd.conf
#sed -i "s@# UserParameter=@UserParameter=ocr_java,ps -ef |grep -v grep |grep java |wc -l@g" /etc/zabbix/zabbix_agentd.conf
sed -i "s%# Include=/usr/local/etc/zabbix_agentd.userparams.conf%Include=/etc/zabbix/zabbix_agentd.conf.d/%g" /etc/zabbix/zabbix_agentd.conf

chkconfig zabbix_agentd on
service zabbix_agentd start