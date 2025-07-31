# Task: Migrate the Ingress to Gateway API
For this question, please set this context (In exam, diff cluster name)

`kubectl config use-context kubernetes-admin@kubernetes`{{exec}}

<br>

Your goal is to replace the `nginx-ingress` with the equivalent Gateway API resources.

1.  **Create a `Gateway` resource named `my-gateway`.**  
    Use the provided `gateway-class`. This resource represents the entry point for traffic.

2.  **Create an `HTTPRoute` resource named `nginx-httproute`.**  
    Attach the `HTTPRoute` to your new `my-gateway`.  
    Define a rule that matches all traffic (`/`) and routes it to the `nginx-service` on port `80`.

3.  **Delete the old Ingress resource (`nginx-ingress`).**  
    Once the Gateway API is configured and traffic is flowing, you can remove the `nginx-ingress`.

You can check if the new setup is working by using `curl` on the Gateway's public IP address.

Once you have completed these steps, your environment will be validated.