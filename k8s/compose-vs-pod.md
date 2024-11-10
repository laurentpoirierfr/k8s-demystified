# Compose vs Pod

## 1. Objectif :

* **docker-compose.yaml** : Permet de définir et d'exécuter plusieurs conteneurs en tant que services sur une seule machine. Il est souvent utilisé pour des environnements de développement et de test locaux.

* **pod.yaml** (Kubernetes) : Permet de déployer un ou plusieurs conteneurs dans un Pod sur un cluster Kubernetes. Un Pod est l'unité de base de déploiement et représente une ou plusieurs instances de conteneurs partageant des ressources et une adresse IP.

## 2. Structure de base :

Exemples minimaux

docker-compose.yaml

```yaml
version: '3'
services:
  app:
    image: nginx
    ports:
      - "80:80"
```

pod.yaml (Kubernetes)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app
spec:
  containers:
    - name: app
      image: nginx
      ports:
        - containerPort: 80
```

## 3. Définition des Conteneurs :

* **docker-compose.yaml** utilise une clé *services* pour définir plusieurs conteneurs, chaque conteneur étant un service.
* **pod.yaml** utilise *containers* sous *spec* pour définir les conteneurs du Pod. Chaque conteneur est listé avec son image et ses paramètres, mais Kubernetes ne permet pas de gérer plusieurs conteneurs dans une seule unité déployable sans passer par des abstractions comme les Deployments ou ReplicaSets pour la gestion de la scalabilité.


## 4. Ports et Réseau :

* **docker-compose.yaml** : Utilise ports pour exposer des *ports* de conteneurs sur l’hôte. On peut spécifier les ports de l’hôte et du conteneur.
* **pod.yaml** : Spécifie *containerPort* sous *ports*, qui expose le port du conteneur au sein du Pod. L'exposition à l'extérieur du cluster se fait généralement via un Service (comme *ClusterIP*, *NodePort*, ou *LoadBalancer*), et non directement dans le Pod.


## 5. Volumes :

* **docker-compose.yaml** : Permet de monter des volumes en utilisant la clé *volumes*, soit des volumes Docker, soit des chemins locaux.
* **pod.yaml** : Utilise aussi *volumes* dans *spec*, mais les volumes sont configurés avec des types Kubernetes spécifiques (par exemple, *hostPath*, *configMap*, *persistentVolumeClaim*).

Exemple dans docker-compose.yaml :

```yaml
services:
  app:
    image: nginx
    volumes:
      - ./data:/data
```

Exemple dans pod.yaml :


```yaml
spec:
  volumes:
    - name: data-volume
      hostPath:
        path: /data
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - mountPath: /data
          name: data-volume
```


## 6. Réplication et Scalabilité :

* **docker-compose.yaml** : Permet de définir le nombre de réplicas avec *scale* dans les versions avancées, mais cette fonctionnalité est limitée et rarement utilisée en production.
* **pod.yaml** : La réplication des Pods se fait via des objets comme *Deployment* ou *ReplicaSet*, ce qui assure une gestion automatique de la scalabilité et de la tolérance aux pannes.

## 7. Variables d’Environnement :

* **docker-compose.yaml** : Utilise *environment* pour définir les variables d’environnement.
* **pod.yaml** : Utilise *env* sous *containers* pour définir des variables d’environnement. Kubernetes permet également d'injecter des variables provenant de ConfigMaps et Secrets.


## 8. Conclusion :

En résumé :

* **docker-compose.yaml** est plus simple, adapté aux environnements locaux et de développement.
* **pod.yaml** est une ressource plus complexe, qui s'intègre à l'écosystème Kubernetes pour un déploiement et une gestion avancés dans des clusters distribués.

Les deux fichiers ont des similitudes dans la déclaration des conteneurs, des ports, des volumes, et des variables d’environnement, mais Kubernetes ajoute des abstractions et des fonctionnalités pour la gestion en production, comme la réplication, la mise à l'échelle et la haute disponibilité.