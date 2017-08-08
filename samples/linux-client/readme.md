# Overview
The following instruction helps you to create a linux client environment where you can create microservice using IBM MicroService Builder, build, package, push image to IBM Cloud Priate where you can deploy (rollout), rollback, scale, your application.

# Pre requisites
- install Vagrant
- install Virtualbox

Vagrant allow the rapid creation of a Linux environment using Virtualbox and automatically
mount a [synchronize folder](https://www.vagrantup.com/docs/synced-folders/) with the host.

Steps
1. Start Linux with
```
vagrant up
```
2. Login to Linux
```
vagrant ssh
```
3. update and upgrade
```
sudo apt-get update && sudo apt-get upgrade
```
4. install docker
```
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo usermod -aG docker $(whoami)
```
5. install python
```
sudo apt-get install python -y
```
6. install python pip
```
sudo apt-get install python-pip -y
```
7. install docker python
```
sudo pip install docker-py
```
8. Install and Set Up kubectl
```
sudo snap install kubectl --classic
```
9. setup ICP client config
- obtain from the ICP menu 'Configure Client' at top right corner of ICP screen
- copy and paste to the command console and hit return
10. configure 'etc/hosts' file to your master.cfc IP
open 'etc/hosts' and your the IP accordingly
```
xxx.xxx.xxx.xxx master.cfc
```
11. login to master private docker Repository
Before you can login you need to add master.cfc ca.cert into your environment.
from the boot node, see [configure certificate](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/manage_images/using_docker_cli.html)
```
docker login master.cfc:8500
```
12. Docker commands
## list images
```
docker images
```
13. Install bluemix configuration
- Install bluemix CLI
```
sh <(curl -fsSL https://clis.ng.bluemix.net/install/linux)
```
-  Install bluemix dev plugin
```
bx plugin install dev -r Bluemix
```
14. Install Maven
```
sudo apt-get install maven -y
```
15. Install Git
```
sudo apt-get install git
```
16. Install Groovy
```
sudo apt-get install groovy -y
```
17. Create a new microservice
- Install Java JDK Before you create microservice
```
sudo apt-get install default-jdk -y
```

```
bx dev create
```
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

? Enter a name for your project> mbdemo

The project, mbdemo, has been successfully saved into the current directory.
OK
```
18. Edit the generated starter codes
edit the sample source codes
```
vi ./mbdemo/src/main/java/application/rest/v1/Example.java
```
add the following
```
@Path("v1/example")
public class Example {
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response hello() {
    /*
    if (!healthy) {
      return Response.status(503).entity("{\"status\":\"DOWN\"}").build();
    }
    */
    return Response.ok("Hello world.").build();
  }
}
```
19. build only the application
```
mvn install
```
20. build and run the application
```
bx dev run
```
21. test and access your application is running
use broswer to access it
```
http://192.168.122.200:9080/mbdemo/v1/example
http://192.168.122.200:9080/mbdemo/health
```
22. If all is good, you are ready to tag and push your image to master.cfc
the push command below push the image to a namespace 'test', once the image is ready for production you can change it to 'global' namespace for all to use.

```
docker login master.cfc
docker tag mbdemo master.cfc:8500/test/mbdemo:v1.0
docker push master.cfc:8500/test/mbdemo:v1.0
```
23. Deploy application in IBM Cloud Private
To deploy your application, go to
- workloads/application/Deploy Application
- In General: enter a name of your choice and define the number of replicas to be deployed
- Container Setting: specifies name and the image: 'master.cfc:8500/test/mbdemo:v1.0'
- you need to expose the application, otherwise the application is not accessible from outside ICP.
- Search for your deployed application, then in the 'Action' column, choose 'Expose', specify
  - Name: 'http'
  - Port: 9000 (choose any port of your choice)
  - Target Port: 9080 (this is your Liberty app port default 9080)

Alternatively, you can define this as a deployment yml file.

# References

## suspend linux
```
vagrant suspend
```

## resume linux
```
vagrant resume
```

## reload after edit Vagrantfile
```
vagrant reload
```

## working the synched folder of host
below folder is a synched folder between linux and the host
```
cd /vagrant
```

## update the linux
```
sudo apt-get update && sudo apt-get upgrade
```

## install helm
```
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
```

[Install helm](https://github.com/kubernetes/helm/blob/master/docs/install.md)

## Install and Set Up kubectl
```
sudo snap install kubectl --classic
```

[Install and Set Up kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## test kuberctl with your cluster
ensure you setup your IBM Clouad Private kube client token

```
kubectl cluster-info
```

## push or pull images from your local file system to the private image registry
Docker image is on a node that is outside of your cluster, set up authentication from that node to the cluster

[Setup instruction](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/manage_images/using_docker_cli.html)


# install bluemix CLI
- download the bluemix CLI
- extract the downloaded file
- run the install script

[online installation](https://console.bluemix.net/docs/cli/reference/bluemix_cli/index.html#getting-started)

```
./Bluemix_CLI/install_bluemix_cli
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

? Enter a name for your project> mbdemo

The project, mbdemo, has been successfully saved into the current directory.
OK
```
## Edit the example source codes
edit the sample source codes

```
./mbdemo/src/main/java/application/rest/v1/Example.java
```
add the following
```
@Path("v1/example")
public class Example {
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Response hello() {
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
make sure you change folder to your project folder 'mbdemo', then run
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
http://192.168.122.200:9080/mbdemo/v1/example
```

```
curl localhost:9080/mbdemo/v1/example
```

# Push codes to Git

create a repo in github and follows the commands as provided by github, in my case,

my sample project can be found [here](https://github.com/js-ibm/mbdemo)


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
sudo apt-get install default-jdk -y
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
