#!/usr/bin/env bash

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install docker.io -y
sudo apt-get install python -y
sudo systemctl start docker
sudo usermod -aG docker $(whoami)
sudo apt-get install python-pip -y
sudo pip install docker-py
sudo snap install kubectl --classic
sh <(curl -fsSL https://clis.ng.bluemix.net/install/linux)
sudo apt-get install maven -y
sudo apt-get install git
sudo apt-get install default-jdk -y
sudo apt-get install groovy -y
sudo apt-get update && sudo apt-get upgrade -y
bx plugin install dev -r Bluemix
cp -R /root/.bluemix/ /home/ubuntu/.bluemix/
sudo chown -R ubuntu:ubuntu /home/ubuntu/.bluemix/
echo "export DOCKER_API_VERSION=1.24" | sudo tee -a /etc/profile
sudo apt-get update && sudo apt-get upgrade
curl -O https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
tar xvf go1.12.1.linux-amd64.tar.gz
sudo chown -R root:root ./go
echo "export GOROOT=$HOME/go" >> ~/.profile
source ~/.profile
echo "export GOPATH=$HOME/work" >> ~/.profile
source ~/.profile
mkdir $GOPATH/bin
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> ~/.profile
source ~/.profile

