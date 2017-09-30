

#### 使用阿里云docker镜像库

阿里云容器hub服务  

https://dev.aliyun.com/search.html


```shell

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://anrkynwr.mirror.aliyuncs.com"]
  }
 EOF

 sudo systemctl daemon-reload
 sudo systemctl restart docker

```  


命令格式： docker pull NAME[:TAG]

- docker pull centos  #默认是centos:latest
- docker run -t -i centos /bin/bash #使用镜像创建容器，并运行bash应用
- docker images #查看本地镜像
- docker tag dl.dockerpool.com:5000/ubuntu:latest  ubuntu:latest #创建标签，都是指向同一个image id
- docker search #搜索镜像
  	docker search tianon/  #只搜索某个用户下的镜像
       
        docker search jenkins  -s 20 #搜索star星级20以上的镜像

- docker rmi images[TAG|id]  
	
	删除本地镜像，格式  Name:Tag| Image id  如果存在多个标签，默认删除标签，只有一个标签则删除镜像

	如果本机上有容器使用该镜像，则也无法删除, -f 强制删除，建议先删除容器，再删除images

- docker ps -a #查看本机上所有存在的容器

- docker rm [ CONTAINER ID ]  #删除容器



Docker在后台运行的标准操作：

1. 检查本地是否存在指定的镜像，不存在就从公有仓库下载

2. 利用镜像创建并启动一个容器

3. 分配一个文件系统，并在只读的镜像层外面挂载一层可读写层

4. 从宿主机配置的网桥接口中桥接一个虚拟接口到容器中去

5. 从地址池配置一个IP地址给容器

6. 执行用户指定的应用程序

7. 执行完毕后容器被终止
