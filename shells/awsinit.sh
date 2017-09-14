#!/bin/bash
#
function shijian()
{
for  ((i=1;i<4;i++));do
        echo -n  "."
        sleep 1
done
}
echo "配置ssh"

if [ -e /root/.ssh/authorized_keys ];then
	cat << EOF >> /root/.ssh/authorized_keys 
ssh-dss AAAAB3NzaC1kc3MAAACBAMvDlRTY2t/UMBwf5VdzUjI1NAFPFy7GoDnxtK9Qho0rA05A9ckUvQPMlHhs93QYmlwIBS0mUH0Labul25fmC+pKOhHo3A2NFz2LPDHJGDMiLWncUrHBHE4yeVq3tjCxIXcvDLPYu8kCUjdpD9SajqOyGxrW4ap4reT37RJL+SNJAAAAFQCmzwHot/UHH/u114790R1M+KXD/QAAAIBJM7QYBJ+4T1sCw+b0xM3M2QDCzUVOJw8cQ3I+Ydk7mKGzwI7JB5kkzl8BS6urcpO4wL2drWq2ZDUJGjYmn3l5I2sUsU1pK2rNSHzh2obkEoQySDpqqhxFVxbCSKiSMwZmyFzEUu4t4z3aPuOD5CscCgG7Hu1eyCsGVQS9Rz9o0gAAAIBMNdV0VzlesXlxqkSQCFAiFNr2u6wskEO7oy60CTkOw9c/3fgPme1zFbu7l5LTrgTNyk3VIvQLaTDXkJkjXrhMscvxdPeMpLKWr+2NfKCFjYEjxTFanu+NbWzVfbqYv6NJ/CkfOn52y8s2WsY/MUyN/7d1SlA40zcz0Mv9ASljfQ== root@JumpServer
EOF
	sed -i  's@#PermitRootLogin yes@PermitRootLogin yes@g' /etc/ssh/sshd_config
	sed -i  's@PermitRootLogin forced-commands-only@#PermitRootLogin forced-commands-only@g' /etc/ssh/sshd_config
	sed -i  's@#PasswordAuthentication yes@PasswordAuthentication yes@g' /etc/ssh/sshd_config
	echo "配置ssh完成，重启sshd服务..."
	shijian
	service sshd restart 
	echo "ssh 配置完成"

else
	echo "No such file /root/.ssh/authorized_keys"
fi

echo "设定时间"
shijian
sed -i  's@ZONE="UTC"@ZONE="Asia/Shanghai"@g' /etc/sysconfig/clock
ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
echo "时间设定ok"
date
