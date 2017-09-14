#!/bin/sh
. /etc/rc.d/init.d/functions
. /etc/bashrc
function INPUT() {
   echo `date +%Y-%m-%d-%H:%M:%S` >>/data/logs/checkservice.log
   echo " " >> /data/logs/checkservice.log
}

while true
do
#com.oradt.job.ServiceStartUp
      Status=` ps aux |grep -v grep |grep CronBundle/run.php |wc -l` 
      if [ $Status -eq 0 ]
      then
      	nohup  /usr/local/php/bin/php /data/webcode/api/src/Oradt/CronBundle/run.php -c=Mipush -f=push &
		echo "CronBundle/run.php - StartUp" >>/data/logs/checkservice.log
        INPUT
      fi
      sleep 10
done