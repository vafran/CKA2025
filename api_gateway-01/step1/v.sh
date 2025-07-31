#!/bin/bash

echo "--- Validating your solution... ---"

# Check Gateway exists
if ! kubectl get gateway my-gateway &> /dev/null; then
    echo "'my-gateway' Gateway resource not found."
    exit 1
fi

# Check HTTPRoute exists
if ! kubectl get httproute nginx-httproute &> /dev/null; then
    echo "'nginx-httproute' HTTPRoute resource not found."
    exit 1
fi

# Check HTTPRoute references the correct Gateway
if ! kubectl get httproute nginx-httproute -o json | grep '"name": "my-gateway"' &> /dev/null; then
    echo "HTTPRoute does not reference 'my-gateway'."
    exit 1
fi

# Check HTTPRoute matches path /
if ! kubectl get httproute nginx-httproute -o json | grep '"path": "/"' &> /dev/null; then
    echo "HTTPRoute does not match path '/'."
    exit 1
fi

# Check HTTPRoute routes to nginx-service on port 80
if ! kubectl get httproute nginx-httproute -o json | grep '"name": "nginx-service"' &> /dev/null; then
    echo "HTTPRoute does not route to 'nginx-service'."
    exit 1
fi
if ! kubectl get httproute nginx-httproute -o json | grep '"port": 80' &> /dev/null; then
    echo "HTTPRoute does not route to port 80."
    exit 1
fi

echo "✅ All resources are correctly configured!"
exit 0