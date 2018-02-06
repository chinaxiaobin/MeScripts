#!/bin/bash
#

source /etc/profile
function kill {
	ps -ef |grep tomcat |grep -v grep |awk '{print $2}' |xargs kill -9
}
STATUS=`ps -ef |grep tomcat |grep -v grep | awk '{print $2}' |wc -l`
if [ $STATUS -ne 0 ];then
	kill
fi


sh /usr/local/tomcat-7/bin/catalina.sh start




* 2 * * *  /bin/sh /data/sh/post.sh &>/tmp/post.log

### 注意：
1. 我们过滤tomcat的命令，其它文件名不要重复，不然容器出问题，比如，我们  ps -ef |grep tomcat,我们追加的日志/tmp/post.log还有
   脚本的名字叫post.sh ，都不要用tomcat这个关键字
   
2. 因为是启动tomcat,需要用到java的环境变量，所以开始的时候我们 source /etc/profile

3. 最后调试脚本即可，看tomcat的进程id是否不一样，来确定我们的脚本执行成功
