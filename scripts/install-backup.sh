#!/bin/bash

set -e

echo "Installing Velero backup stack..."

helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
helm repo update

kubectl create namespace velero --dry-run=client -o yaml | kubectl apply -f -

helm install velero vmware-tanzu/velero \
-n velero \
-f backup/velero/velero-values.yaml

echo "Velero installation completed."
