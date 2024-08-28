# Kubernetes guidance

This guidance is aimed at those deploying to and supporting Kubernetes clusters and includes helpful how to guides for common Kubernetes tasks and lessons learned.

## Configure NGINX Ingress Controller
An [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) is an application that runs in a Kubernetes cluster and configures an HTTP load balancer according to Ingress resources.

In the case of NGINX, the Ingress controller is deployed in a pod along with
the load balancer.

### Installation
The documentation for [NGINX's chart](https://github.com/kubernetes/ingress-nginx) includes details on how to install it.

*TL;DR:*

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install my-release ingress-nginx/ingress-nginx
```

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

**Warning** if the file parameter is not passed, the Kubeconfig will be merged with the users default configuration file stored at `~/.kube/config`.
This can result in the file becoming corrupted due to the nature of the merge.

## Productivity Tools
Developers may find it more productive to use tools such as [k9s](https://github.com/derailed/k9s) or [kubectl-aliases](https://github.com/ahmetb/kubectl-aliases) to avoid needing to regularly type long terminal commands to interact with the cluster.

## Authenticating with cloud resources
Both Azure and AWS' managed Kubernetes service, AKS and EKS respectively offer mechanisms to authenticate with cloud resources without the need for credential management in applications.

### AAD Pod Identity (Azure)
With this approach, Pod Identity pods are deployed to a cluster.
Application code then uses these resources to request tokens to use in subsequent authentication requests to Azure resources.  Identity mappings are also deployed to the cluster.

Token lifecycle is managed within the application itself, some Azure resources have official SDKs that manage this lifecycle, but others the developer must handle the token refresh themselves.

See full setup details in the [official documentation](https://github.com/Azure/aad-pod-identity).

### IAM role for Service Accounts (AWS)
With this approach, only an identity mapping resource is required and the cluster will automatically ensure a valid token is available to the application.

As token lifecycle is managed outside of the application, this approach results in less complex application code than the Azure implementation.

See full setup details in the [official documentation](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)

### Azure - AAD Pod Identity
AAD Pod Identity enables Kubernetes applications to access cloud resources securely with Azure Active Directory (AAD).

Using Kubernetes primitives, administrators configure identities and bindings to match pods. Then your containerized applications can leverage any resource in the cloud that depends on AAD as an identity provider.

See Kubernetes [Secret standards](../standards/kubernetes_standards.md) for standards for secret management when Pod Identity is not suitable.

## Probes
Kubernetes has two types of probes, readiness and liveness.

Kubernetes uses readiness probes to know when a container is ready to start accepting traffic.

Kubernetes uses liveness probes to know when to restart a container.

### Configuring probes
Probes can be configured in the Helm chart on a `Deployment` resource, under the container node.

The below is a simple example of an HTTP readiness and liveness probes.

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
`path`: the URL route the liveness probe should sent a response to

`port`: the port on which the service is exposing

`initialDelaySeconds`: how long before the first probe should be sent. This should be safely longer than it takes the pod to start up, otherwise the pod could be stuck in a reboot loop

`periodSeconds`: how often the liveness probe should check the pod is responsive. Recommendation is between 10 and 20 seconds

`failureThreshold`: how many probe failures before the pod is automatically restarted

As well as HTTP probes, there are also command and TCP based probes, full details can be found in the documentation https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/

## Descheduler
Scheduling in Kubernetes is the process of binding pending pods to nodes, and is performed by a component of Kubernetes called kube-scheduler. 

The scheduler's decisions, whether or where a pod can or can not be scheduled, are guided by its configurable policy which comprises of set of rules, called predicates and priorities. 

The scheduler's decisions are influenced by its view of a Kubernetes cluster at that point of time when a new pod appears for scheduling. 

As Kubernetes clusters are very dynamic and their state changes over time, there may be desire to move already running pods to some other nodes for various reasons:

- some nodes are under or over utilised
- the original scheduling decision does not hold true any more, as taints or labels are added to or removed from nodes, pod/node affinity requirements are not satisfied any more
- some nodes failed and their pods moved to other nodes
- new nodes are added to clusters
- consequently, there might be several pods scheduled on less desired nodes in a cluster

Descheduler, based on its policy, finds pods that can be moved and evicts them

Descheduler can be installed using Helm as described [here](https://github.com/kubernetes-sigs/descheduler#install-using-helm)

## Autoscaling
Kubernetes pods and nodes can be automatically scaled on demand.  See below resources for usage.

[Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)

[Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler)

[Cluster autoscaling (AKS)](https://docs.microsoft.com/en-us/azure/aks/cluster-autoscaler)

[Cluster autoscaling (EKS)](https://aws.amazon.com/premiumsupport/knowledge-center/eks-cluster-autoscaler-setup/)
