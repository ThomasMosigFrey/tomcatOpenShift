#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
CHAOS_NS=chaos-testing

CHAOS_MESH_VERSION=2.1.3

export DRY_RUN=""

function usage {
  echo "script usage: $(basename $0) [-d] [-h]"
  echo "             -d      - dry run"
  echo "             -h      - prints out this message"
}

while getopts 'dh' OPTION; do
  case "${OPTION}" in
    d)
      export DRY_RUN="echo "
      ;;
    h)
      usage
      exit 0
      ;;
  esac
done

if [ "$(oc whoami)" != kube:admin ]; then
  echo "Error, you must be logged into a k8s cluster as user kube:admin"
  exit 4
fi

chaosNS=$(oc get ns | grep -i -- ${CHAOS_NS} | awk '{ print $1}')
if [ -z "${chaosNS}" ]
then
  $DRY_RUN oc create ns ${CHAOS_NS}
fi
#$DRY_RUN  oc apply -f ${SCRIPT_DIR}/ClusterRoleBinding.yaml
$DRY_RUN oc adm policy add-scc-to-user privileged -n ${CHAOS_NS} -z chaos-daemon
$DRY_RUN oc adm policy add-scc-to-user privileged -n ${CHAOS_NS} -z chaos-dns-server

$DRY_RUN helm install chaos-mesh https://charts.chaos-mesh.org/chaos-mesh-${CHAOS_MESH_VERSION}.tgz -n=${CHAOS_NS} -f ${SCRIPT_DIR}/chaos-mesh-values.yaml
