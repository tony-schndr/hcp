#!/bin/bash

NAMESPACE=default

kubectl create ns hypershift-monitoring-stack
kubectl create ns operators

kubectl create -k observability-operator/deploy/crds/kubernetes/
kubectl create -k observability-operator/deploy/dependencies/
kubectl create -k observability-operator/deploy/operator/


kubectl apply -f ./manifests/monitoring-stack.yaml

# Add label to ns to allow pods from monitoring namespace connect ocm* namespaces
kubectl label ns ${NAMESPACE} network.openshift.io/policy-group=monitoring
