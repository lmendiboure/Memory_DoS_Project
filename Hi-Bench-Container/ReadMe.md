# Objective

Docker container that can run different HiBench workloads (Hadoop workloads).

# Required tools on your machine

Docker, Kubernetes, MiniKube

# Deployment Procedure

To run it with Minikube:
```console
# Start minikube
# Note: Memory and CPU could be configured depending on your machine and requirements

minikube start --memory 32000 --cpus 2 

# Set docker env

eval $(minikube docker-env)

# Build image
# Note: DOCKER_BUILDKIT=0 could be required to see the build state
# Note: name used for the image should also be specified in the hibench-deployment.yaml file

DOCKER_BUILDKIT=0 docker build -t hibench:0.0.1 .

# Define a new namespace that will be used to deploy the pod
# Note: a specific configuration is used to increase the amount of resource that can be used by this pod: avoid potentiel error 137 and enables both Hadoop and HiBench operation

kubectl create namespace qos-hibench

# Run in minikube
 
kubectl apply -f hibench-deployment.yaml --namespace=qos-hibench

# Access Shell
kubectl exec --namespace=qos-guaranteed hibench-pod --stdin --tty -- /bin/bash

```
Potential useful commands
  1. kubectl get pods --namespace=qos-guaranteed
  2. kubectl delete pods hibench-pod namespace=qos-guaranteed
  3. kubectl get pod hibench-pod --namespace=qos-guaranteed --output=yaml



# Use


To run workloads (once container started) - Could be directly integrated within RUN to directly obtain result and automatically stop the container once results are obtained:
  1. ```bin/workloads/micro/wordcount/prepare/prepare.sh```
  2. ```bin/workloads/micro/wordcount/hadoop/run.sh```

# Known Errors

If an error 137 occurs during once the pod is launched, it could be related to the limited memory resources allocated to Docker Containers.

To deal with that, it would be necessary :

  1. To modify the `/etc/docker/daemon.json` file to increase the amout of resources that are memory allocated to Docker containers (initially 10Go). The following lines should be added:

       a. "storage-driver": "devicemapper",
       b. "storage-opts": ["dm.basesize=40G"]
  
  2. Restart the docker deamon: `sudo service docker restart`
