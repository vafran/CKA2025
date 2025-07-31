#!/bin/bash

# This script validates the user's solution.
# It checks for the non-existence of the old Ingress and the existence of the new Gateway API resources.

echo "--- Validating your solution... ---"

# 1. Check if the Ingress resource has been deleted
if kubectl get ingress nginx-ingress &> /dev/null; then
    echo "Validation failed: The 'nginx-ingress' resource still exists."
    exit 1
fi
echo "✅ 'nginx-ingress' has been successfully deleted."

# 2. Check for the existence of the Gateway API resources
if ! kubectl get gateway my-gateway &> /dev/null; then
    echo "Validation failed: 'my-gateway' Gateway resource not found."
    exit 1
fi
echo "✅ 'my-gateway' Gateway resource found."

# 3. Check for the existence of the HTTPRoute resource
if ! kubectl get httproute nginx-httproute &> /dev/null; then
    echo "Validation failed: 'nginx-httproute' HTTPRoute resource not found."
    exit 1
fi
echo "✅ 'nginx-httproute' HTTPRoute resource found."

# If all checks pass, the script will continue and print the success message
echo "--- Validation successful! ---"
echo "You have successfully migrated the routing from Ingress to the Gateway API."
exit 0