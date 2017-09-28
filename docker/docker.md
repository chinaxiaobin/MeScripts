

####使用阿里云docker镜像库

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

