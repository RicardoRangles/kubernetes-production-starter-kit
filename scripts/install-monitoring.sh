#!/bin/bash

set -e

echo "---------------------------------------"
echo "Kubernetes Production Starter Kit"
echo "Installing Monitoring Stack"
echo "---------------------------------------"

echo "Adding Helm repository..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo "Updating Helm repositories..."
helm repo update

echo "Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "Installing kube-prometheus-stack..."
helm install monitoring prometheus-community/kube-prometheus-stack \
-n monitoring \
-f configs/kube-prometheus-stack-values.yaml

echo "Applying monitoring ingress..."
kubectl apply -f networking/monitoring-ingress.yaml

echo "---------------------------------------"
echo "Monitoring stack installation completed"
echo "---------------------------------------"
