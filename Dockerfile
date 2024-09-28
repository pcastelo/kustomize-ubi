FROM registry.access.redhat.com/ubi8/ubi-minimal:8.9

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'
RUN microdnf install -y curl ca-certificates git wget tar gzip bash jq dnf  \
    && microdnf update \
    && microdnf clean all 

RUN dnf install python39 -y \
    && python3 -m pip install --upgrade pip wheel \
    && python3 -m pip install httpie

RUN wget https://github.com/mikefarah/yq/releases/download/v4.43.1/yq_linux_amd64 -O /usr/local/bin/yq    
RUN curl -sLO https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.4.1/kustomize_v5.4.1_linux_amd64.tar.gz \
    && tar -xzf kustomize*.tar.gz \
    && install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/yq
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#USER 1001


