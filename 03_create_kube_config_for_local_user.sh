#!/bin/bash

clear

TARGET_USER=bboros
K8S_NS=local-dev
LOCAL_CONFIG_FILE=config_microk8s


TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
echo -e "Backup /home/${TARGET_USER}/.kube/config file as /home/${TARGET_USER}/.kube/config_backup_${TIMESTAMP}"
mv /home/${TARGET_USER}/.kube/config /home/${TARGET_USER}/.kube/config_backup_${TIMESTAMP}


echo -e "\n\n\nCopy config from microk8s"
microk8s.kubectl config view > /home/${TARGET_USER}/.kube/${LOCAL_CONFIG_FILE}_orig


echo -e "\n\n\nCreate namespace: ${K8S_NS}"
microk8s.kubectl create namespace ${K8S_NS}


echo -e "\n\n\nCreate context: ${K8S_NS}"
microk8s.kubectl config set-context ${K8S_NS} --namespace=${K8S_NS} --cluster=microk8s-cluster --user=admin


echo -e "\n\n\nUse context: ${K8S_NS}"
microk8s.kubectl config use-context ${K8S_NS}


echo -e "\n\n\nList namespaces"
microk8s.kubectl get namespace



echo -e "\n\n\nSet active config file"
microk8s.kubectl config view > /home/${TARGET_USER}/.kube/${LOCAL_CONFIG_FILE}


echo "Turn off checking certificate to avoid \"Unable to connect to the server: x509: certificate signed by unknown authority\" errors from kubectl"
sed -i 's/certificate-authority-data: DATA+OMITTED/#certificate-authority-data: DATA+OMITTED\n    insecure-skip-tls-verify: true/g' /home/${TARGET_USER}/.kube/${LOCAL_CONFIG_FILE}


cp  /home/${TARGET_USER}/.kube/${LOCAL_CONFIG_FILE} /home/${TARGET_USER}/.kube/config
chown ${TARGET_USER}:${TARGET_USER} /home/${TARGET_USER}/.kube/config





