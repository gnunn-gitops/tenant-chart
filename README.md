### Provisioning Tenants

This is a helm chart for provisioning tenants on a cluster in a GitOps fashion. I was doing this with kustomize but
was finding I was doing a lot of copy and paste between tenants, using templating via a helm chart helms reduce this.

There is minimal documentation at this point, see the values.yaml file for an example of how to do use it.

Note the intent is for this chart to be used with the kustomize helm inflator, as a result there is minimal
overriding of resources provided. Basically the philosphy is to make automatic inclusion a true/false thing
and if you want to customize something simply don't include enable it in the chart and just add it as a
separate resource to the kustomization.

Credit to Thomas Jungbauer for the original concepts linked in his blog article below.

### ApplicationSet

Each tenant gets their own version of the chart that specifies the namespaces and resources required for that tenant. These
can be organized into a directory structure in git and then an ApplicationSet can be used with the git generator to
automatically generate the tenant applications.

Here is an [example](https://github.com/gnunn-gitops/cluster-config/blob/main/clusters/overlays/local.home/components/tenants/appset.yaml) ApplicationSet from my cluster-config repository:

```
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: tenants
  namespace: openshift-gitops
spec:
  generators:
  - git:
      directories:
      - path: tenants/**/base
      repoURL: https://github.com/gnunn-gitops/cluster-config
      revision: main
  goTemplate: true
  syncPolicy:
    preserveResourcesOnDeletion: true
  template:
    metadata:
      name: tenant-{{ index .path.segments 1 | normalize }}
    spec:
      destination:
        name: in-cluster
        namespace: default
      project: cluster-config
      source:
        path: '{{ .path.path }}'
        repoURL: https://github.com/gnunn-gitops/cluster-config
      syncPolicy:
        automated:
          selfHeal: true

```

### Package chart

Use `helm package .`` to package the chart.

### Other Examples

There are other examples of Helm charts for this including:

* Thomas Jungbauer wrote a nice blog on [Onboarding Projects with Helm and ApplicationSets](https://cloud.redhat.com/blog/project-onboarding-using-gitops-and-helm)
* Trevor Royer has a [Helm chart](https://github.com/strangiato/helm-charts/tree/main/charts/gitops-tenant) as well.
