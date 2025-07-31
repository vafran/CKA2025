# Upgrading from Ingress to Gateway API

The Kubernetes Gateway API is the successor to the Ingress API, offering a more expressive, extensible, and role-oriented approach to managing application traffic. It provides greater flexibility for advanced routing, traffic splitting, and policy attachment.

In this scenario, you'll be given a simple web application that is exposed via a standard Kubernetes Ingress resource. Your task is to:

1.  Examine the existing Ingress configuration.
2.  Create the equivalent routing using the Gateway API (`GatewayClass`, `Gateway`, and `HTTPRoute`).
3.  Delete the original Ingress resource once your new configuration is working.

Let's begin!
