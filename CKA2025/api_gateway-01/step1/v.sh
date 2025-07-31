#!/bin/bash

if ! kubectl get gateway my-gateway &> /dev/null; then
    echo "'my-gateway' Gateway resource not found."
    exit 1
fi

if ! kubectl get gateway my-gateway -o json | grep '"gatewayClassName": "my-gateway-class"' &> /dev/null; then
    echo "'my-gateway' does not use 'my-gateway-class' as gatewayClassName."
    exit 1
fi

if ! kubectl get httproute nginx-httproute &> /dev/null; then
    echo "'nginx-httproute' HTTPRoute resource not found."
    exit 1
fi

if ! kubectl get httproute nginx-httproute -o json | grep '"name": "my-gateway"' &> /dev/null; then
    echo "HTTPRoute does not reference 'my-gateway'."
    exit 1
fi

if ! kubectl get httproute nginx-httproute -ojsonpath='{.spec.rules[*].matches[*].path.value}' | grep / &> /dev/null; then
    echo "HTTPRoute does not match path '/'."
    exit 1
fi

if ! kubectl get httproute nginx-httproute -o json | grep '"name": "nginx-service"' &> /dev/null; then
    echo "HTTPRoute does not route to 'nginx-service'."
    exit 1
fi
if ! kubectl get httproute nginx-httproute -o json | grep '"port": 80' &> /dev/null; then
    echo "HTTPRoute does not route to port 80."
    exit 1
fi

echo "All resources are correctly configured!"
exit 0