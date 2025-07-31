#!/bin/bash

# This script validates the user's solution.
# It checks for the existence of the Gateway API resources.

echo "--- Validating your solution... ---"

# 1. Check for the existence of the Gateway resource
if ! kubectl get gateway my-gateway &> /dev/null; then
    echo "Validation failed: 'my-gateway' Gateway resource not found."
    exit 1
fi
echo "✅ 'my-gateway' Gateway resource found."

# 2. Check for the existence of the HTTPRoute resource
if ! kubectl get httproute nginx-httproute &> /dev/null; then
    echo "Validation failed: 'nginx-httproute' HTTPRoute resource not found."
    exit 1
fi
echo "✅ 'nginx-httproute' HTTPRoute resource found."

echo "--- Validation successful! ---"
echo "You have successfully configured routing using the Gateway API."
exit 0