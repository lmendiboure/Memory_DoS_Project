The idea is to deploy a k8s architecture integrating CRI-RM (https://intel.github.io/cri-resource-manager/stable/docs/index.html) using kind.

To use it, the following commands could be useful :
  1. docker build -t cri-rm-node  // To build the docker image that will be used as node by the kind cluster
  2. kind create cluster --name cri-rm-cluster --image cri-rm-node // create cluster using our specific node image
  3. kind delete cluster --name cri-rm-cluster // delete cluster
  4. kubectl apply -f test.yaml // create pod
  5. docker exec -it cri-rm-cluster-control-plane /bin/bash -> journalctl -f // verify that cri-rm is running and used as a proxy by the pods to CRI (containerd with kind)


Example file for simple pod:
```console
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: test-pod
    image: kicbase/echo-server:1.0
    ports:
    - containerPort: 80
```

To reset the policy in real-time (within a given node):
```console
stop cri-resmgr (systemctl stop cri-resource-manager)
reset policy data (cri-resmgr --reset-policy)
change policy ($EDITOR /etc/cri-resource-manager/fallback.cfg)
start cri-resmgr (systemctl start cri-resource-manager)
```

To execute that in real-time, a simple solution could be imaged. For example: docker cp a local policy to the different nodes + launch a script (docker exec container script)
