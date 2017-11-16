# 进程相关

ps aux | grep java  unix BSD风格 查看进程的cpu占用率和内存占用率

ps -ef | grep java  system-v风格 查看进程的父进程ID和完整的COMMAND命令

ps -A  | grep java  直接获取相关进程的pid

# grep命令
grep -rn "字符串"  ./  在当前目录下查找与该字符串相关的文件
