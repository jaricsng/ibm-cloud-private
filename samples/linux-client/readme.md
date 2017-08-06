# Pre requisites
- install Vagrant
- install Virtualbox

# start the ubuntu linux
```
vagrant up
```

# suspend linux
```
vagrant suspend
```

# resume linux
```
vagrant resume
```

# reload after edit Vagrantfile
```
vagrant reload
```

# login to the linux
```
vagrant ssh-keygen
```
# update the linux
```
sudo apt-get update && sudo apt-get upgrade
```

# install docker
```
sudo apt-get install docker.io -y
```

# start docker daemon
```
sudo systemctl start docker
```

# set user of docker
```
sudo usermod -aG docker $(whoami)
```

# install python
```
sudo apt-get install python -y
```

# install python pip
```
sudo apt-get install python-pip -y
```

# install docker python
```
sudo pip install docker-py
```

# install helm
```
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
```

[Install helm](https://github.com/kubernetes/helm/blob/master/docs/install.md)

# Install and Set Up kubectl
```
sudo snap install kubectl --classic
```

[Install and Set Up kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

# test kuberctl with your cluster
ensure you setup your kube client token

```
kubectl cluster-info
```
