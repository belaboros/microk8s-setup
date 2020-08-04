kubectl run hello-kubernetes \
   --replicas=3 \
   --image=belaboros/hello-kubernetes \
   --port=8080