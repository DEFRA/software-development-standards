# Kubernetes standards

## Standards
### Use a managed Kubernetes service
Managed Kubernetes services such as Azure Kubernetes Service (AKS) in Azure or Elastic Kubernetes Service (EKS) in AWS are used as opposed to any IaaS Kubernetes implementation.

This is because managed Kubernetes services abstract the maintenance and configuration of master nodes to the cloud provider, meaning teams only need to support the worker nodes where services run.  Maintaining a full Kubernetes cluster can be very complicated and requires a high level of in depth Kubernetes and networking knowledge which can be a barrier to entry for some teams.  Using a managed service significantly reduces this complexity.

### Use Helm for packaging deployments
[Helm](https://helm.sh/) is a tool to bundle individual Kubernetes configuration files into single deployable packages.  This significantly reduces the complexity of configuring a cluster and deploying applications to it.

Helm >=3 must be used and teams should never use Helm 2 due to security risk introduced by running Tiller in a cluster.

Teams are also encouraged to use a Helm Library chart to reduce duplication of Helm charts across multiple services.  Such as [this one](https://github.com/DEFRA/ffc-helm-library) used by the Farming and Countryside Programme (FCP).

### Use ConfigMaps for configuration
Configuration for an application running in a pod should be passed to the pod via a `ConfigMap` Kubernetes resource. 
The `ConfigMap` is more flexible than just using environment variables alone, and as well as supporting file based values, allows decoupling of pod definitions from configuration definitions.

Environment specific values should be overridden during the Helm deployment.

Sensitive values should never be passed to a `ConfigMap`.

### Secrets
Where possible, secrets should not be stored within an application or Kubernetes pod.  Instead, when communicating with supported cloud infrastructure, clusters should use [Entra ID Workload Identities](https://learn.microsoft.com/en-us/azure/aks/workload-identity-overview?tabs=dotnet) in Azure or [IAM role for Service Accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html) in AWS.

When secrets in a pod are unavoidable, for example when a third party API key is needed, secrets should be injected into pods during deployment.

> Note: the Kubernetes `Secrets` resource type stores data as Base64 encoded as opposed to encryption.  Ensure appropriate access controls are in place for reading cluster secrets.

### Labels
Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system. 

Labels can be used to organise and to select subsets of objects. Labels can be attached to objects at creation time and subsequently added and modified at any time. Each object can have a set of key/value labels defined. Each Key must be unique for a given object.

In order to take full advantage of using labels, they should be applied on every resource object within a Helm chart. i.e. all deployments, services, ingresses etc.

#### Required labels
Each Helm chart templated resource should have the below labels. Example placeholders are provided for values.

```yaml
metadata:
  labels:
    app: {{ quote .Values.namespace }}
    app.kubernetes.io/name: {{ quote .Values.name }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/version: {{ quote .Values.labels.version }}
    app.kubernetes.io/component: {{ quote .Values.labels.component }}
    app.kubernetes.io/part-of: {{ quote .Values.namespace }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
    environment: {{ quote .Values.environment }}
```

**Note** `Deployment` resource objects should have two sets of labels, one for the actual deployment and another for the pod template the deployment manages.

### Selectors
Services selectors should be matched by app and name. Selectors should be consistent otherwise updates to Helm charts will be rejected.

```yaml
selector:
  app: {{ quote .Values.name }}
  app.kubernetes.io/name: {{ quote .Values.name }}
```

### Resource usage
Predictable demands are important to help Kubernetes find the right place for a pod within a cluster. When it comes to resources such as a CPU and memory, understanding the resource needs of a pod will help Kubernetes allocate the pod to the most appropriate node and generally improve the stability of the cluster.

#### Declaring a profile
- all pods declare both a `request` and `limit` value for CPU and memory
- production clusters do not contain any `best-effort` pods
- pods with consistent usage patterns are run as`guaranteed` pods (i.e. equal `request` and `limit values`)
- pods with spiky usage patterns can be run as `burstable` but effort should be taken to understand why performance is not consistent and whether the service is doing too much

#### Resource profiling
Performance testing a pod is the only way to understand it's resource utilisation pattern and needs. Performance testing should take place on all pods to accurately understand their usage before they can be deployed to production.

### Resource quotas
Clusters will limit available resources within a namespace using a `resourceQuota` to improve cluster stability. 

An example `ResourceQuota` definition is included below

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-resource-quota
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
```

### Pod priority
Kubernetes Pods can have priority levels. Priority indicates the importance of a pod relative to other pods. If a pod cannot be scheduled, the scheduler tries to preempt (evict) lower priority pods to make scheduling of the pending pod possible.

In the event of over utilisation of a cluster, Kubernetes will start to kill lower priority pods first to maintain stability.

Clusters should include pod priority classes that teams can consume based on their service needs.  The below gives examples of the Pod Priority classes available in FFC clusters.

#### High (1000) 
Reserved primarily for customer facing or critical workload pods.

#### Default (600)
Default option suitable for most pods.

#### Low (200)
For pods where downtime is more tolerable.

Below is a full example of a `priorityClass` resource definition for reference.

```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: default
value: 600
globalDefault: true
description: "This priority class should be used for most services"
```

#### Resource profile impact
In the event a cluster has to make a choice between killing one of two services sharing the same priority level, the resource profile configuration will influence which is killed.

### Probes
To increase the stability and predictability of a Kubernetes cluster, services should make use of readiness, liveness and startup probes unless there is a significant reason not to.

Probe end points should follow the convention of `healthy` for readiness probes and `healthz` for liveness/startup probes.
