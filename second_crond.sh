#!/bin/bash
# /usr/local/demo.sh
# Description： 生产中我们需要执行秒级别任务，而默认crond支持分钟级别 



while : ;do
	command    #你要执行的命令
	sleep 30   #默认是秒
done


##定时任务中设置执行该脚本

* * * * * /bin/bash   /usr/local/demo.sh