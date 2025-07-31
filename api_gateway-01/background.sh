#!/bin/bash

# This script sets up the initial environment for the scenario.
# It creates a simple Nginx deployment, a service, and an Ingress resource.

echo "--- Installing Gateway API CRDs ---"
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

# Wait for the CRDs to be available
sleep 10

echo "--- Installing Contour as the Gateway API implementation ---"
kubectl apply -f https://projectcontour.io/quickstart/contour-gateway-provisioner.yaml
kubectl apply -f https://projectcontour.io/quickstart/gateway-provisioner-gatewayclass.yaml

# Wait for Contour to be ready
echo "Waiting for Contour pods to be ready..."
kubectl wait --for=condition=ready pod -l app=contour --timeout=300s -n projectcontour

echo "--- Creating the initial Nginx application ---"
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21.6
        ports:
        - containerPort: 80
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
EOF

echo "--- Creating the existing Ingress resource ---"
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-service
            port:
              number: 80
EOF

# Give a moment for all resources to become available
sleep 5

echo "--- Initial setup complete! ---"
echo "You now have a running Nginx application exposed via an Ingress resource."
echo "Use 'kubectl get all' to see the resources."