echo "microk8s.status:"
microk8s.status

echo -e "\n\nmicrok8s.kubectl cluster-info:"
microk8s.kubectl cluster-info


echo -e "\n\nDashboard cluster IP"
microk8s.kubectl get all --all-namespaces |grep kubernetes-dashboard | grep ClusterIP


#kubernetes.io/cluster-service=true

echo -e "\n\nmicrok8s kubectl get all --all-namespaces"
microk8s kubectl get all --all-namespaces