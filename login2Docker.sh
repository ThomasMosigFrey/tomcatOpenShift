#openshift

oc project openshift-image-registry
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
HOST=$(oc get route default-route --template='{{ .spec.host }}')
echo "Container Registry URL: $HOST"

#docker 
docker login -u kubeadmin -p $(oc whoami -t) $HOST

