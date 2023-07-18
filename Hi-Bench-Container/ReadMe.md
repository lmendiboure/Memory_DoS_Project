Docker container that can run different HiBench workloads (Hadoop workloads). Includes Hadoop (Local Cluster) + HiBench

To build it:
```sudo docker build --tag 'test_hi' .```

To run it (launches SSH Server + HDFS):
```sudo docker run -it test_hi```

To run workloads (once container started) - Could be directly integrated within RUN to directly obtain result and automatically stop the container once results are obtained:
  1. ```bin/workloads/micro/wordcount/prepare/prepare.sh```
  2. ```bin/workloads/micro/wordcount/hadoop/run.sh```

To run it with Minikube (example):
```console
# Start minikube
minikube start

# Set docker env
eval $(minikube docker-env)

# Build image
docker build -t hibench:0.0.1 .

# Run in minikube
kubectl run hibench-pod --image=hibench:0.0.1 --image-pull-policy=Never

# Access Shell
kubectl exec --stdin --tty hello-foo -- /bin/bash
```
