# Pre requisites
- install Vagrant
- install Virtualbox

Vagrant allow the rapid creation of a Linux environment using Virtualbox and automatically
mount a [synchronize folder](https://www.vagrantup.com/docs/synced-folders/) with the host.



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
ensure you setup your IBM Clouad Private kube client token

```
kubectl cluster-info
```

# push or pull images from your local file system to the private image registry
Docker image is on a node that is outside of your cluster, set up authentication from that node to the cluster

[Setup instruction](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/manage_images/using_docker_cli.html)

```
docker login master.cfc:8500
```

```
docker build -t hello-world-image .
```

# install bluemix CLI
- download the bluemix CLI
- extract the downloaded file
- run the install script

[online installation](https://console.bluemix.net/docs/cli/reference/bluemix_cli/index.html#getting-started)

```
./Bluemix_CLI/install_bluemix_cli
```

# Install Maven
```
sudo apt-get install maven
```

# Install git
```
sudo apt-get install git
```

# Create Java MicrcoService
## Pre requisites
- Install Bluemix CLI
- Java JDK
- Docker if development locally
- bluemix developer plugin

## create application using bluemix CLI
```
bx dev create
```
response to the prompt as follows, at end it will create a java liberty project folder with Dockerfile, Jenkinsfile, maven build file.

```
Log in to Bluemix using the bx login command to synchronize your projects with the Bluemix dashboard, and to enable the use of Bluemix services in your project.
? Do you wish to continue without logging in? [y/n]> y
? Select a pattern:                        
1. Web App
2. Mobile App
3. Backend for Frontend
4. Microservice
Enter a number> 4

? Select a starter:
1. Basic
Enter a number> 1

? Select a language:
1. Java
Enter a number> 1

? Enter a name for your project> jsLibertyApp

The project, jsLibertyApp, has been successfully saved into the current directory.
OK
```
## Edit the example source codes
edit the sample source codes

```
./jsLibertyApp/src/main/java/application/rest/v1/Example.java
```
add the following
```
@Path("v1/example")
public class Example {
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response healthcheck() {
    /*
    if (!healthy) {
      return Response.status(503).entity("{\"status\":\"DOWN\"}").build();
    }
    */
    return Response.ok("Hello world.").build();
  }
}
```

## build only the application
```
mvn install
```

## build and run the application

```
bx dev run
```

## access the application
the linux client which is created using vagrant uses 192.168.122.200 in the Vaagrantfile.
you can access the Liberty application using the following url.
```
http://192.168.122.200:9080/
```

```
curl localhost:9080/jsLibertyApp/v1/example
```

# Push codes to Git

create a repo in github and follows the commands as provided by github, in my case,

in the jsLibertyApp folder, run git init
```
echo "# jsLibertyApp" >> README.md
git init
git add .
git commit -m "initial commit"
git remote add origin git@github.com:js-ibm/jsLibertyApp.git
git push -u origin master
```
my sample project can be found [here](https://github.com/js-ibm/jsLibertyApp)


# Troubleshooting

### cannot login to master cfc private docker repo
if you encountered the following error, makes sure you add the certificate of the master node.
```
ubuntu@master:~$ docker login master.cfc:8500

Error response from daemon: Get https://master.cfc:8500/v1/users/: x509: certificate signed by unknown authority
```

Resolve the issue you need to copy the copy the configure-registry-cert.sh from master.cfc master node

### error running bx dev create
```
'dev' is not a registered command. See 'bx help'.
```
[follow the steps to get developer plugin](https://console.bluemix.net/docs/cloudnative/dev_cli.html#developercli)

#### Install dev plugin
```
bx plugin install dev -r Bluemix
```

### Install JDK on ubuntu
[help notes on install and managing JDK environment](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04)
```
sudo apt-get install default-jdk
```

### Install Oracle JDK
```
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
```

### install Oracle JDK 8
```
sudo apt-get install oracle-java8-installer
```

### error running bx dev run
```
The run-cmd option was not specified
Stopping the 'jslibertyapp' container...
The 'jslibertyapp' container was not found
Creating image jslibertyapp based on Dockerfile...
FAILED                
Image failed to build:
Error response from daemon: client is newer than server (client API version: 1.29, server API version: 1.24)

Dumping output from the command:

```
you can set docker API version in environment
```
export DOCKER_API_VERSION=1.24
```

[for other methods due to docker API incompatibility](https://stackoverflow.com/questions/43072703/client-is-newer-than-server-client-api-version-1-24-server-api-version-1-21)
