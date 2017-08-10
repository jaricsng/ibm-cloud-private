# IBM Cloud Private Notebook

# Preparation
- [preparing the cluster for installation](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/installing/prep_cluster.html)

# install

- [Installing IBM Cloud private with Vagrant + Virtualbox](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/Setting_up_an_IBM_Spectrum_Conductor_for_Containers_cluster_by_using_Vagrant?lang=en)
- [Installing IBM Cloud private-ce in offline mode](https://developer.ibm.com/recipes/tutorials/installing-ibm-cloud-privatece-in-offline-mode/)

# Use Cases

- [Deploy MQ into IBM Cloud private](https://developer.ibm.com/recipes/tutorials/deploy-mq-into-ibm-cloud-private/)
- [Working with storage](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/Working_with_storage?lang=en)
- [Setting up the Microservice Builder pipeline](https://www.ibm.com/support/knowledgecenter/en/SS5PWC/pipeline.html)
- [Deploy Db2 into IBM Cloud private](https://developer.ibm.com/recipes/tutorials/deploy-db2-into-ibm-cloud-private/)
- [Installing the Microservice Builder ELK Sample with Kubernetes](https://github.com/WASdev/sample.microservicebuilder.helm.elk/blob/master/installing_sample_elk_task.md)
- [Load balancing applications by using session affinity](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/Load_balancing_applications_with_session_affinity?lang=en)
- [Configuring the Kubernetes CLI by using service account tokens](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/Configuring_the_Kubernetes_CLI_by_using_service_account_tokens1?lang=en)
- [Running Jenkins workloads in an IBM Cloud private environment](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/CI_CD_Integration_with_Jenkins_in_CFC1?lang=en)
- [Autoscaling in IBM Cloud private](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/Autoscaling_in_IBM_Spectrum_for_Containers_clusters?lang=en)
- [How Watson Health Cloud Deploys Applications with Kubernetes](http://blog.kubernetes.io/2017/07/how-watson-health-cloud-deploys.html)

# Microservice Builder
- [Installing the Microservice Builder fabric on to IBM Cloud private](https://www.ibm.com/support/knowledgecenter/SS5PWC/installing_fabric_task.html)
- [Setting up the Microservice Builder pipeline](https://www.ibm.com/support/knowledgecenter/SS5PWC/pipeline.html)
- [Install Microservice Builder ELK sample](https://github.com/WASdev/sample.microservicebuilder.helm.elk/blob/master/installing_sample_elk_task.md)
- [Using the ELK Sample](https://github.com/WASdev/sample.microservicebuilder.helm.elk/blob/master/sample_elk_task.md)
- Video [Microservice Builder: come build Docker containerized apps with us](https://www.youtube.com/watch?v=8w-XqDAD18g)

# DevOps UrbanCode Deploy
- [Enhance your Kubernetes Experience with UrbanCode Deploy](https://developer.ibm.com/urbancode/2017/06/28/enhance-kubernetes-experience-urbancode-deploy/)
- [Kubernetes Blue-Green Deployments Made Easy with UrbanCode Deploy](https://developer.ibm.com/urbancode/2017/07/26/kubernetes-blue-green-deployments-made-easy-urbancode-deploy/)

# User access via ICP UI

In System menu, you can
- create namespace for [multi tenancy](https://www.youtube.com/watch?v=SDFDpTMZTjc&index=2&list=PLA-Z7DV3wrOWeUQbv-C2zs3IvBCWFGpTC)
- create quota for resource
- add repo for helm charts
- add users

# Demo purpose
1. ssh into master node
2. docker login
```
docker login master.cfc:8500
```

## Docker image
Example
namespace: test
image_name: hello-world-image
tagname: v1.0.0

### tag image
```
docker tag image_name:tagname master.cfc:8500/namespacename/imagename:tagname
```

```
docker tag hello-world-image:v1.0.0 master.cfc:8500/test/hello-world-image:v1.0.0
```

### Push image
Push the image to the private image registry.
```
docker push master.cfc:8500/namespacename/imagename:tagname
```
```
docker push master.cfc:8500/test/hello-world-image:v1.0.0
```
### Pull image
```
docker pull master.cfc:8500/namespacename/imagename:tagname
```
```
docker pull master.cfc:8500/test/hello-world-image:v1.0.0
```
### Create a sample nodejs image
in the samples/nodejs folder, run the following command
```
docker build -t hello-world-image .
```
### Push & Pull into IBM Cloud Private
[Pushing and pulling images](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/manage_images/using_docker_cli.html)
### Deploy the docker image
#### Deploy using deployment.yaml
```
kubectl create -f deployment.yml --save-config
```

#### Deploy using UI
![Deploy application dialog](https://github.com/jaricsng/ibm-cloud-private/blob/master/deploy-app-dialog-1.png)
![Deploy application dialog](https://github.com/jaricsng/ibm-cloud-private/blob/master/deploy-app-dialog-2.png)
### Expose the application endpoint
#### Expose the Service to Internet
```
kubectl expose deployment hello-world-deployment --type="LoadBalancer"
```

#### Expose using UI
![Expose application dialog](https://github.com/jaricsng/ibm-cloud-private/blob/master/expose-app-service.png)
![Expose application dialog](https://github.com/jaricsng/ibm-cloud-private/blob/master/expose-port-mapping.png)

### Access the application
![Access application](https://github.com/jaricsng/ibm-cloud-private/blob/master/access-app-1.png)
![Access application](https://github.com/jaricsng/ibm-cloud-private/blob/master/access-app-2.png)
![Access application](https://github.com/jaricsng/ibm-cloud-private/blob/master/access-app-3.png)

### Scale the application

### View application status


# Best Practices
## Docker
- [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
- [Docker Reference Architecture: Development Pipeline Best Practices Using Docker EE](https://success.docker.com/Architecture/Docker_Reference_Architecture%3A_Development_Pipeline_Best_Practices_Using_Docker_EE)
## Helm Chart
- [Best practices for Helm Chart](https://docs.helm.sh/chart_best_practices/)
## Kubernetes
- [kubectl Usage Conventions](https://kubernetes.io/docs/user-guide/kubectl-conventions/)
- [Security Best Practices for Kubernetes Deployment](http://blog.kubernetes.io/2016/08/security-best-practices-kubernetes-deployment.html)
-
## etcd
- [Best practice for etcd](https://coreos.com/operators/etcd/docs/latest/best_practices.html)

# References
- [IBM Cloud Private Knowledge center](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html)
- [Docker](https://docs.docker.com/)
- [Downlad Bluemix CLI](https://clis.ng.bluemix.net/ui/home.html?cm_sp=dw-bluemix-_-microservice-builder-_-devcenter&cm_mc_uid=47402820653814918773981&cm_mc_sid_50200000=1501752774)
- [Kubernetes Concepts](https://kubernetes.io/docs/concepts/)
- [Community Helm chart repo](https://kubernetes-charts.storage.googleapis.com)
- [Community Incubator helm charts repo](https://kubernetes-charts-incubator.storage.googleapis.com/)
- [MicrcoService Builder Helm chart Repo](http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/microservicebuilder/helm/)
- [IBM Helm chart repo](https://raw.githubusercontent.com/IBM/charts/master/repo/stable/)
- [Microservice Builder](https://developer.ibm.com/microservice-builder/)
- [Using RBAC Authorization](https://kubernetes.io/docs/admin/authorization/rbac/)
- [Kubernetes tutorials](https://kubernetes.io/docs/tutorials/)
- [About WebSphere Liberty](https://developer.ibm.com/wasdev/websphere-liberty/)
- [Deploying the sample via a pipeline to IBM Cloud Private aka IBM Spectrum Conductor for Containers (CfC)](https://github.com/WASdev/sample.microservicebuilder.docs/blob/master/full_cfc.md)
- [Networking with Kubernetes](https://www.youtube.com/watch?v=WwQ62OyCNz4)

# Organizational roles
- [Organizational roles:](https://www.ibm.com/devops/method/content/culture/practice_organizational_roles/1_0) DevOps at scale calls for a number of common roles, each requiring unique skills and domain knowledge.
- [Get started](https://www.ibm.com/devops/method/content/course/get_started_agile_cd/0) with agile development and continuous delivery

# Videos
[IBM Spectrum Conductor for Containers Community Edition](https://www.youtube.com/watch?v=jchAHkc9rDo)
- demonstrate adding docker images
- image namespace
- deploy images
- Scaling
- update application e.g. nginx to httpd
- rollback application e.g from httpd back to nginx
- create storage, volume, mounting to application at deployment
- create users, namespace
[Build and Continuously Deliver a Java Microservices App in IBM Cloud private](https://www.ibm.com/developerworks/community/blogs/5092bd93-e659-4f89-8de2-a7ac980487f0/entry/Build_and_Continuously_Deliver_a_Java_Microservices_App_in_IBM_Cloud_private?lang=en)
- shows key services we used, and how an application, “Stock Trader”, is setup and deployed, a Java microservices app running in Liberty, that uses not only Db2, MQ, and Redis, but also connects to our public cloud.
