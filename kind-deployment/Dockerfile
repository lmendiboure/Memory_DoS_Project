# Dockerfile for kind-node with a simple patch enabling to launch cri-rm

# Base image (xUbuntu 20.04)
FROM quay.io/aojea/kindnode:crio1630331170

RUN echo "Installing CRI-RM Packages ..." \
  && curl -sLO https://github.com/intel/cri-resource-manager/releases/download/v0.8.3/cri-resource-manager_0.8.3_ubuntu-20.04_amd64.deb && dpkg -i cri-resource-manager_0.8.3_ubuntu-20.04_amd64.deb 

RUN echo "Copying required config file : policy + logs rules"
COPY ./fallback.cfg /etc/cri-resmgr/fallback.cfg

# Alternatively, usual fallback fila can also be used. Previous line need to be removed and next one added 

# && mv /etc/cri-resmgr/fallback.cfg.sample /etc/cri-resmgr/fallback.cfg

# Remove useless crio install
# quay.io/aojea/kindnode:crio1630331170 intended to use crio but here the objective is to add cri-resource-manager

#RUN echo "Removing useless installs" \
# && apt-get remove -y cri-o cri-o-runc \
# && rm -r /etc/crio/

RUN echo "Manage systemctl services" \
 && systemctl enable containerd \
# && systemctl disable crio \
 && systemctl enable cri-resource-manager \
 && sed '/KUBELET_EXTRA_ARGS/ s!$! --container-runtime-endpoint=/var/run/cri-resmgr/cri-resmgr.sock!' -i /etc/default/kubelet \
 && systemctl enable kubelet.service
