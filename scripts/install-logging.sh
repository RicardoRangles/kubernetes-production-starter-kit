#!/bin/bash

set -e

echo "Installing Fluent Bit logging stack..."

helm repo add fluent https://fluent.github.io/helm-charts
helm repo update

kubectl create namespace logging --dry-run=client -o yaml | kubectl apply -f -

helm install fluent-bit fluent/fluent-bit \
-n logging \
-f logging/fluent-bit/fluent-bit-values.yaml

echo "Fluent Bit installation completed."
