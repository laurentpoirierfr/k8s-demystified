# Liste des Ressources Kubernetes / lexique

## 1 . Ressources de calcul et de déploiement

* **ReplicaSet** : Garantit qu'un nombre spécifié de Pods est en cours d'exécution.
* **Deployment** : Gère les mises à jour déclaratives des Pods et des ReplicaSets, souvent utilisé pour déployer des applications.
* **StatefulSet** : Utilisé pour déployer des applications nécessitant une identité stable et un stockage persistant (par exemple, les bases de données).
* **DaemonSet** : Assure que chaque nœud exécute une instance d'un Pod spécifié (utile pour les agents de monitoring ou de journalisation).
* **Job et CronJob** : Gèrent l'exécution de tâches ponctuelles (Job) ou récurrentes (CronJob) au sein du cluster.


## 2. Ressources de réseau

* **Service** : Expose des Pods pour permettre l'accès au réseau, au sein du cluster (ClusterIP), ou en externe (NodePort, LoadBalancer).
* **Ingress** : Gère les routes HTTP et HTTPS vers les services en fonction des URL, facilitant l’accès depuis l’extérieur du cluster.
* **NetworkPolicy** : Définit des règles de contrôle d'accès réseau entre Pods et Services pour renforcer la sécurité.

## 3. Ressources de stockage

* **PersistentVolume (PV) et PersistentVolumeClaim (PVC)** : Gèrent les volumes de stockage, en les réclamant et les attachant aux Pods.
* **StorageClass** : Permet de définir des profils de stockage, souvent pour l’allocation dynamique de volumes en fonction de la configuration du cluster et du fournisseur de stockage.

## 4. Ressources de configuration

* **ConfigMap** : Stocke des configurations non sensibles, telles que des variables d'environnement, des fichiers de configuration, ou des arguments de ligne de commande.
* **Secret** : Stocke des données sensibles comme les mots de passe, les clés d'API et les certificats de manière sécurisée.


## 5. Ressources de sécurité et de contrôle d'accès

* **ServiceAccount** : Fournit une identité pour les Pods afin d'accéder aux ressources du cluster de manière sécurisée.
* **Role et ClusterRole** : Définit des autorisations (par exemple, lecture, écriture) pour les ressources. Les Roles sont restreints à un namespace, tandis que les ClusterRoles s'appliquent à l'ensemble du cluster.
* **RoleBinding et ClusterRoleBinding** : Attachent des Roles ou des ClusterRoles aux utilisateurs, groupes, ou ServiceAccounts pour accorder les permissions.

## 6. Ressources pour la gestion des volumes

* **Volume** : Représente un volume de stockage dans un Pod, mais contrairement aux PV, il est éphémère et se limite au cycle de vie du Pod.
* **EphemeralVolume** : Volumes temporaires qui durent le temps d’un Pod et sont automatiquement nettoyés ensuite.

## 7. Ressources de gestion de la surveillance et des métriques

* **HorizontalPodAutoscaler (HPA)** : Permet de mettre à l'échelle le nombre de réplicas d'un Deployment ou d'un ReplicaSet en fonction de métriques comme la charge CPU ou d’autres indicateurs personnalisés.
* **VerticalPodAutoscaler (VPA)** : Ajuste les ressources (CPU et mémoire) des Pods en fonction de l’utilisation.
* **PodDisruptionBudget (PDB)** : Définit le nombre minimum de Pods disponibles lors des opérations de maintenance, comme les mises à jour ou les redémarrages de nœuds.

* **CustomResourceDefinition (CRD)** : Permet aux utilisateurs de définir leurs propres types de ressources pour étendre Kubernetes avec de nouvelles fonctionnalités.

## 8. Ressources de gestion de la charge de travail et des événements

* **Event** : Enregistre des événements qui surviennent dans le cluster, comme des erreurs ou des informations liées au cycle de vie des ressources.
* **LimitRange** : Définit des limites de ressources pour les Pods et les containers dans un namespace.
* **ResourceQuota** : Impose des limites au niveau d’un namespace sur la quantité de ressources utilisables (CPU, mémoire, stockage, etc.).


Ces ressources, combinées entre elles, permettent d’orchestrer, de configurer, de sécuriser, et de surveiller efficacement les applications dans Kubernetes.