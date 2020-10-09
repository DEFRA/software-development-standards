# Kubernetes guidance

## Configure NGINX Ingress Controller
An [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) is an application that runs in a Kubernetes cluster and configures an HTTP load balancer according to Ingress resources.

In the case of NGINX, the Ingress controller is deployed in a pod along with
the load balancer.

### Installation
The documentation for [NGINX's chart](https://github.com/helm/charts/blob/master/stable/nginx-ingress/README.md) includes details on how to install it.

*TL;DR:*

`helm install stable/nginx-ingress --name nginx-ingress`

### Creating a namespace for a service
Each service in a cluster will have their own dedicated namespace in each cluster.

This allows logical separation between services as well as the enabling simpler implementation of monitoring, RBAC and stability mechanisms.

## Requirements
The following are the suggested outcomes of a namespace.
- `ResourceQuota` resource to limit resource usage
- `RoleBinding` resource to restrict interaction to delivery team

Example setup instructions are included in the [FFC Kubernetes Configuration](https://github.com/DEFRA/ffc-kubernetes-configuration) repository.

## Install Kubernetes dashboard
The Kubernetes dashboard is a web-based Kubernetes user interface.

### Installation
Install the dashboard to a Kubernetes cluster using the `kubectl apply` command specified in the **Deploying the dashboard UI** section in the below link.

https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

Example:
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml`

#### Create default user and access token
Follow the guide in the below link.
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

#### Run dashboard
1. Run terminal command `kubectl proxy`
1. Access dashboard at http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

## Interact with cluster
`kubectl` is used to interact with the cluster.  In order to use `kubectl` with an FFC cluster, a `kubeconfig` file for the cluster is required.

### Acquiring a Kubeconfig file for a cluster in AKS
To acquire a Kubeconfig, a subscription Id is needed along with the name of the cluster and the resource group in which it resides.  This information can be acquired via the Azure Portal or from CSC.

`az account set --subscription SUBSCRIPTION_ID`

`az aks get-credentials --resource-group RESOURCE_GROUP --name CLUSTER --file WHERE_TO_SAVE_KUBECONFIG`

**Note** if the file parameter is not passed, the Kubeconfig will be merged with the users default configuration file stored at `~/.kube/config`.

## Productivity Tools
Developers may find it more productive to use tools such as [k9s](https://github.com/derailed/k9s) or [kubectl-aliases](https://github.com/ahmetb/kubectl-aliases) to avoid needing to regularly type long terminal commands to interact with the cluster.

## AAD Pod Identity
AAD Pod Identity enables Kubernetes applications to access cloud resources securely with Azure Active Directory (AAD).

Using Kubernetes primitives, administrators configure identities and bindings to match pods. Then your containerized applications can leverage any resource in the cloud that depends on AAD as an identity provider.

## Probes
Kubernetes has two types of probes, readiness and liveness.

Kubernetes uses readiness probes to know when a container is ready to start accepting traffic.

Kubernetes uses liveness probes to know when to restart a container.

### Configuring probes
Probes can be configured in the Helm chart on a `Deployment` resource, under the container node.

The above is a simple example of an Http readiness and liveness probes.

```
readinessProbe:
  path: /healthy
  port: 3000
  initialDelaySeconds: 10
  periodSeconds: 10
  failureThreshold: 3

livenessProbe:
  path: /healthz
  port: 3000
  initialDelaySeconds: 10
  periodSeconds: 10
  failureThreshold: 3
```

In this example, the cluster will wait for 10 seconds after the pod is deployed.  It will then poll both the liveness and readiness endpoints on port 3000 every 10 seconds.  

If it receives three successive status codes other than 200 for the readiness probe it will stop routing traffic to that pod.

If it receives three successive status codes other than 200 for the liveness probe it will assume the pod is unresponsive and kill it.

**Note** that a liveness probe works in conjunction with the restartPolicy value. In order to restart the restartPolicy must be set to Always or OnFailure.

#### Values
`path`: the URL route the liveness probe should sent a response to.

`port`: the port on which the service is exposing

`initialDelaySeconds`: how long before the first probe should be sent. This should be safely longer than it takes the pod to start up, otherwise the pod could be stuck in a reboot loop

`periodSeconds`: how often the liveness probe should check the pod is responsive. Recommendation is between 10 and 20 seconds

`failureThreshold`: how many probe failures before the pod is automatically restarted

As well as Http probes, there are also command and TCP based probes, full details can be found in the documentation https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/
