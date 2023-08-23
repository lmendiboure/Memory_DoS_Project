sudo apt-get update

# install kind -> specific version that is compatible with the deployed node, corresponds to one of the last non-rootless versions of kind

sudo curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64 \
  && sudo chmod 0755 /usr/local/bin/kind)

# install kubelet, kubeadm and kubectl, kubectl is required to interact with the kind cluster. Tested with vers 1.25.2 and 1.28.0-1.1

sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
