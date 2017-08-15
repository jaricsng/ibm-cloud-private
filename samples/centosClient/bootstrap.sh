#!/usr/bin/env bash

sudo yum -y update
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $(whoami)
sudo yum groupinstall -y development
sudo yum install -y zlib-dev openssl-devel sqlite-devel bzip2-devel
wget http://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
xz -d Python-2.7.13.tar.xz
tar -xvf Python-2.7.13.tar
cd Python-2.7.13
./configure --prefix=/usr/local
make
sudo make altinstall
export PATH="/usr/local/bin:$PATH"
cd ..
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python2.7 get-pip.py
sudo pip install docker-py
sudo yum install /lib/ld-linux.so.2 -y
cd /opt/
curl -s get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install groovy
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-i586.tar.gz"
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
sudo tar xzf jdk-8u141-linux-i586.tar.gz
sudo tar xzf apache-maven-3.3.9-bin.tar.gz
sudo ln -s apache-maven-3.3.9 maven
sudo touch /etc/profile.d/maven.sh
export M2_HOME=/opt/maven
echo "export M2_HOME=/opt/maven" | sudo tee -a /etc/profile.d/maven.sh
echo "export PATH=${M2_HOME}/bin:${PATH}" | sudo tee -a /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
cd /opt/jdk1.8.0_141/
sudo alternatives --install /usr/bin/java java /opt/jdk1.8.0_141/bin/java 2
sudo alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_141/bin/jar 2
sudo alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_141/bin/javac 2
#sudo alternatives --config java
sudo alternatives --set jar /opt/jdk1.8.0_141/bin/jar
sudo alternatives --set javac /opt/jdk1.8.0_141/bin/javac
export JAVA_HOME=/opt/jdk1.8.0_141
export JRE_HOME=/opt/jdk1.8.0_141/jre
export PATH=$PATH:/opt/jdk1.8.0_141/bin:/opt/jdk1.8.0_141/jre/bin
sudo yum install git
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
# sh <(curl -fsSL https://clis.ng.bluemix.net/install/linux)
# bx plugin install dev -r Bluemix
# sudo cp -R /root/.bluemix/ /home/vagrant/.bluemix
# sudo chown -R vagrant:vagrant /home/vagrant/.bluemix/
echo "export DOCKER_API_VERSION=1.24" | sudo tee -a /home/vagrant/.bash_profile
#sudo yum -y update
