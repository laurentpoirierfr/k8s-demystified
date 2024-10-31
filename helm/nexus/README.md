# k9s-nexus

```bash
# Ajout du dépot sonatype dans ma registry local
helm repo add sonatype https://sonatype.github.io/helm3-charts/

# Recherche des versions présentent dans le dépôt.
helm search repo sonatype

NAME                                    CHART VERSION   APP VERSION     DESCRIPTION                                       
stable/sonatype-nexus                   1.23.1          3.20.1-01       DEPRECATED - Sonatype Nexus is an open source r...
sonatype/nexus-iq-server                183.0.0         1.183.0         Sonatype Nexus IQ Server continuously monitors ...
sonatype/nexus-iq-server-ha             183.0.0         1.183.0         A cluster of Sonatype Nexus IQ Servers to conti...
sonatype/nexus-repository-manager       64.2.0          3.64.0          DEPRECATED Sonatype Nexus Repository Manager - ...
sonatype/nxrm-aws-resiliency            64.2.0          3.64.0          DEPRECATED Resilient AWS Deployment of Sonatype...
sonatype/nxrm-ha                        73.0.0          3.73.0          Resilient Deployment of Sonatype Nexus Reposito...
sonatype/nxrm-ha-aws                    61.0.3          3.61.0          DEPRECATED Resilient AWS Deployment of Sonatype...
sonatype/nxrm-ha-azure                  61.0.3          3.61.0          DEPRECATED Resilient Azure Deployment of Sonaty...

# Récupération des values
helm show values sonatype/nexus-repository-manager > values-nexus.yaml

# Création d'un namespace nexus
kubectl create ns nexus

# Installlation de nexus avec le values
helm install -f values-nexus.yaml nexus-iq sonatype/nexus-repository-manager --namespace nexus

WARNING: This chart is deprecated
NAME: nexus-iq
LAST DEPLOYED: Wed Oct 23 19:18:55 2024
NAMESPACE: nexus
STATUS: deployed
REVISION: 1
NOTES:
1. Your ingresses are available here:
  http://repo.demo.local/

```

## References

* https://medium.com/linux-shots/helm-chart-repository-on-sonatype-nexus-oss-fcf6f7c7498e
* https://help.sonatype.com/en/helm-repositories.html
* https://github.com/chartmuseum/helm-push
