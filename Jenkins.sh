#!/bin/bash
#java -jar /usr/local/Cellar/jenkins/2.58/libexec/jenkins.war --httpPort=9090

echo 'centos7 install docker'


command="$1"

install_docker(){

sudo yum update

sudo yum install -y yum-utils \
device-mapper-persistent-data \
lvm2 \
git

sudo yum-config-manager \
--add-repo \
https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo

sudo yum makecache fast
sudo yum install docker-ce
sudo yum install docker-compose
sudo systemctl enable docker
sudo systemctl start docker

}


install_docker_image()
{
echo "Select the need to install docker images:"
echo "1. jenkins"
echo "2. gitlab"
echo "3. opensips"
echo "4. tomcat"
echo "5. redis"
echo "6. nginx"

read paramter
sleep 0.5
image=$paramter

if [ -n $image ]
then
    if [ $image = "1"  ] ; then
        docker pull jenkins/jenkins
    elif [ $image = "2"  ] ; then
        docker pull gitlab/gitlab-ce
    elif [ $image = "4"  ] ; then
        docker pull tomcat:8-jre8
    elif [ $image = "5" ] ; then
        docker pull  redis
    elif [ $image = "3"  ] ; then
        docker pull imaccloud/docker-opensips
    elif [ $image = "6" ] ; then
        docker pull nginx
    else
    echo "Invalid input parameter."
    exit 0
    fi
else
    echo "Input parameter is nil."
    exit 0
fi

}

help()
{
echo "站着别动，我去买橘子."
exit 1
}

run()
{

case $command in
docker)
    install_docker
    ;;
images)
    install_docker_image
    ;;
*)
    help
    ;;
esac

}

run


echo "Success."

