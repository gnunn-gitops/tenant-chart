### Provisioning Tenants

This is a helm chart for provisioning tenants on a cluster in a GitOps fashion. I was doing this with kustomize but
was finding I was doing a lot of copy and paste between tenants, using templating via a helm chart helms reduce this.

There is minimal documentation at this point, see the values.yaml file for an example of how to do use it.

Note the intent is for this chart to be used with the kustomize helm inflator, as a result there is minimal
overriding of resources provided. Basically the philosphy is to make automatic inclusion a true/false thing
and if you want to customize something simply don't include enable it in the chart and just add it as a
separate resource to the kustomization.

### Other Examples

There are other examples of Helm charts for this including:

* Thomas Jungbauer wrote a nice blog on [Onboarding Projects with Helm and ApplicationSets](https://cloud.redhat.com/blog/project-onboarding-using-gitops-and-helm)
* Trevor Royer has a [Helm chart](https://github.com/strangiato/helm-charts/tree/main/charts/gitops-tenant) as well.
