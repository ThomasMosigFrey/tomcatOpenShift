#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
CHAOS_NS=chaos-testing

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
  echo "Error, you must be logged into a k8s cluster as user ocpadmin"
  exit 4
fi

# uninstall chaos mesh
$DRY_RUN oc delete -f ${SCRIPT_DIR}/ClusterRoleBinding.yaml
$DRY_RUN oc delete project ${CHAOS_NS}
