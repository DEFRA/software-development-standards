# Kubernetes standards

# Configuration
Configuration for an application running in a pod should be passed to the pod via a `ConfigMap` Kubernetes resource.

The configuration values should be stored in Azure Application Configuration and injected via CI.

# Helm chart
Helm charts allow multiple Kubenetes resource definitions to be deployed and undeployed as a single unit.

Helm version 3 is used within FFC.  

Helm 2 should never be used due to security risk introduced by Tiller in a cluster.

## Source control
- Helm charts are source controlled in the same repository as the microservice they relate to

- Helm charts are saved in a `helm` directory and named the same as the repository. For example a chart referencing the ELM Payment Service would be stored in the `./helm/elm-payment-service` directory

- Helm chart versions are automatically updated by CI in line with the application version

## Helm chart library
- to keep Helm charts DRY, the [FFC Helm Chart Library](https://github.com/DEFRA/ffc-helm-library) is used as a base for all resource definitions

- consuming Helm charts only need to define where there is variation from the base Helm chart

## Helm chart repository
- Helm charts are published to a Helm chart repository using Azure Container Registry

- Helm charts for in flight Pull Requests are not published

# Labels
Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system. 

Labels can be used to organise and to select subsets of objects. Labels can be attached to objects at creation time and subsequently added and modified at any time. Each object can have a set of key/value labels defined. Each Key must be unique for a given object.

In order to take full advantage of using labels, they should be applied on every resource object within a Helm chart. i.e. all deployments, services, ingresses etc.

## Required labels
Each Helm chart templated resource should have the below labels. Example placeholders are provided for values.

```
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

## Selectors
Services selectors should be matched by app and name. Selectors should be consistent otherwise updates to Helm charts will be rejected.
```
selector:
  app: {{ quote .Values.name }}
  app.kubernetes.io/name: {{ quote .Values.name }}
```

## Further reading
More information is available in [Confluence](https://eaflood.atlassian.net/wiki/spaces/FPS/pages/1618214984/Kubernetes+labels)

# Pod priority
Kubernetes Pods can have priority levels. Priority indicates the importance of a pod relative to other pods. If a pod cannot be scheduled, the scheduler tries to preempt (evict) lower priority pods to make scheduling of the pending pod possible.

In the event of over utilisation of a cluster, Kubernetes will start to kill lower priorty pods first to maintain stability.

## Priority levels available to FFC pods
There are three defined pod priority levels available within an FFC cluster.  A deployment must specify one of these levels.

### High (1000) 
Reserved primarily for customer facing or critical workload pods.

### Default (600)
Default option suitable for most pods.

### Low (200)
For pods where downtime is more tolerable.

The `priorityClass` definitions that relate to these levels can be viewed in the [ffc-kubernetes-configuration](https://github.com/DEFRA/ffc-kubernetes-configuration/tree/master/priority-classes) repository.

## Resource profile impact
In the event a cluster has to make a choice between killing one of two services sharing the same priority level, the [resource profile](resource-usage.md) configuration will influence which is killed.

## Further reading
More information is available in [Confluence](https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/)

# Probes
To increase the stability and predicatability of a Kubernetes cluster, services should make use of both readiness and liveness probes unless there is a significant reason not to.

Probe end points should follow the convention of `healthy` for readiness probes and `healthz` for liveness probes.

# Role Based Access Control (RBAC)
FFC clusters enable RBAC through `RoleBinding` Kubernetes resources.

Each delivery team will have it's own Rolebinding so permissions can be permitted or denied on a team level.

## Development cluster
- Platform team developers have Cluster Admin role allowing them full access to the cluster

- Delivery team developers are restricted to only namespaces they own

# Resource usage
Predictable demands are important to help Kubernetes find the right place for a pod within a cluster. When it comes to resources such as a CPU and memory, understanding the resource needs of a pod will help Kubernetes allocate the pod to the most appropriate node and generally improve the stability of the cluster.

## Declaring a profile
- all pods declare both a `request` and `limit` value for CPU and memory
- production clusters do not contain any `best-effort` pods
- pods with consistent usage patterns are run as`guaranteed` pods (i.e. equal `request` and `limit values`)
- pods with spiky usage patterns can be run as `burstable` but effort should be taken to understand why performance is not consistent and whether the service is doing too much

## Resource quotas
FFC clusters will limit available resources within a namespace using a `resourceQuota`. This quota can be viewed in the [ffc-kubernetes-configuration](https://github.com/DEFRA/ffc-kubernetes-configuration/tree/master/resource-quotas) repository.

Services which require an exception to this limit should raise a request with the Platform Services team.

## Resource profiling
Performance testing a pod is the only way to understand it's resource utilisation pattern and needs. Performance testing should take place on all pods to accurately understand their usage before they can be deployed to production.

# Further reading
More information is available in [Confluence](https://eaflood.atlassian.net/wiki/spaces/FPS/pages/1616576613/Pod+resource+usage)

# Secrets
Where possible, secrets should not be stored within an application or Kubernetes pod.  Instead, clusters should use [AAD Pod Identity](https://github.com/Azure/aad-pod-identity) as per Microsoft recommendation.

When secrets in a pod are unavoidable, for example when a third party API key is needed, secrets should be stored in Azure Key Vault and injected into Kubernetes `Secret` resources via CI.

**Note** The approach for unavoidable secrets is under review and it is likely that the programme will adopt a tool such as [Kubernetes Secrets Store CSI Driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver).
