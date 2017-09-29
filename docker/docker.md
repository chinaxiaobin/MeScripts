

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
- docker rmi images[TAG|id]  
	
	删除本地镜像，格式  Name:Tag| Image id  如果存在多个标签，默认删除标签，只有一个标签则删除镜像

	如果本机上有容器使用该镜像，则也无法删除

- docker ps -a #查看本机上所有存在的容器
