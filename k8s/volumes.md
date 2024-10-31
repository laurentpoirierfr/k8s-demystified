# Les gestion des volumes

Voici un exemple de mise en œuvre de PersistentVolume (PV) et de PersistentVolumeClaim (PVC) dans Kubernetes avec un montage NFS et une référence à un système de fichiers local.

## 1. Configuration du PersistentVolume (PV)

Pour utiliser un système de fichiers NFS, assurez-vous d'avoir un serveur NFS prêt, accessible depuis le cluster, avec un répertoire exporté pour le stockage.

Exemple de définition de PersistentVolume (PV) avec NFS :

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  nfs:
    path: /exported/path/on/nfs-server
    server: nfs-server.local  # Remplacez par l'adresse de votre serveur NFS
  persistentVolumeReclaimPolicy: Retain  # Peut être "Delete" ou "Recycle" selon vos besoins
```

## 2. Configuration du PersistentVolumeClaim (PVC)

Le PersistentVolumeClaim permet de réclamer de l'espace de stockage défini par le PV.

Exemple de définition de PersistentVolumeClaim :

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi

```

Dans cet exemple, le PVC réclame 5 Go de stockage, qui doit être disponible dans le PV spécifié.

## 3. Utilisation de la PVC dans un Pod

Pour monter le volume NFS réclamé par le PVC dans un Pod, spécifiez-le dans la configuration du Pod ou du Deployment.

Exemple de Pod utilisant la PVC :

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nfs-pod
spec:
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - mountPath: "/usr/share/nginx/html"
      name: nfs-storage
  volumes:
  - name: nfs-storage
    persistentVolumeClaim:
      claimName: nfs-pvc
```

## 4. Exemple de PersistentVolume avec un système de fichiers local

Pour utiliser un stockage local, vous pouvez spécifier un hostPath dans le PV. Assurez-vous que chaque nœud du cluster a le répertoire nécessaire et qu’il est accessible.

Exemple de PersistentVolume avec hostPath :

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /data/k8s-local-storage  # Remplacez par le chemin souhaité sur le nœud
  persistentVolumeReclaimPolicy: Retain
```

## Points à noter

* **hostPath** est utilisé pour des tests ou pour un stockage à usage unique sur un nœud spécifique. Il ne convient pas pour les charges de travail nécessitant une haute disponibilité.
* **NFS** est plus adapté pour le partage de fichiers entre Pods car il prend en charge ReadWriteMany.
* Le **PersistentVolumeReclaimPolicy** définit ce qui se passe lorsque le PVC est supprimé (ex : Retain, Recycle, ou Delete).



## Volume vs Ephemeral Volume

La différence entre un ephemeral volume et un volume dans Kubernetes réside dans leur durée de vie et leur usage prévu.

### 1. Volume

Un **Volume** dans Kubernetes est une ressource de stockage utilisée par un Pod pour stocker des données. Ce stockage peut être persistant ou temporaire, selon le type de volume spécifié. Les **PersistentVolumes (PVs)**, par exemple, sont un type de volume durable, conçu pour conserver les données indépendamment du cycle de vie du Pod. D'autres types de volumes comme **hostPath** et **emptyDir** peuvent être temporaires ou non partagés entre Pods, mais persistent aussi longtemps que le Pod est actif.


**Caractéristiques des volumes classiques** :

* **Cycle de vie variable** : Peut être persistant (PersistentVolume) ou temporaire (hostPath, emptyDir).
* **Types divers** : Inclut des types de volumes supportant différents fournisseurs de stockage (par exemple, AWS EBS, Azure Disk, NFS, etc.).
* **Usage partagé** : Les volumes peuvent être partagés par plusieurs Pods dans certains cas (ex : ReadWriteMany avec des volumes comme NFS).

### 2. Ephemeral Volume

Un **Ephemeral Volume** est un volume de stockage temporaire qui dure uniquement le temps de vie d'un Pod. Lorsque le Pod est supprimé ou redémarré, le contenu du volume éphémère est supprimé. Ce type de volume est destiné aux usages où les données sont requises temporairement, par exemple pour le cache, les fichiers temporaires, ou les configurations qui ne doivent pas persister.

Kubernetes propose plusieurs types de volumes éphémères :

* **emptyDir** : Créé à cha+que démarrage du Pod, dure jusqu'à la fin du Pod, et disparaît ensuite.
* **configMap, secret, downwardAPI** : Montent des informations spécifiques dans le Pod pour sa durée de vie seulement.
* **Ephemeral volume type** : Les volumes définis comme éphémères par les CSI (Container Storage Interface) drivers, permettant d'utiliser le stockage local pour des usages temporaires tout en supportant des configurations de stockage avancées.


**Caractéristiques des volumes éphémères** :

* **Cycle de vie limité** : Attachés à un Pod unique et disparaissent dès que le Pod est supprimé.
* **Types spécifiques** : Comprend emptyDir, configMap, secret, ou des volumes via CSI drivers conçus pour être temporaires.
* **Usage unique** : Idéal pour les données temporaires ou locales d'un Pod et non destiné au partage de données ou aux sauvegardes persistantes.


Comparaison Résumée

| Caractéristique	| Volume	| Ephemeral Volume |
| --- | --- | --- |
| Durée de vie	| Variable (temporaire ou persistante)	| Limitée à celle du Pod |
| Type de stockage	| Divers (PV, NFS, AWS, Azure, etc.)	| Volumes temporaires (ex: emptyDir, secret) |
| Partage entre Pods	| Possible (selon le type)	| Non partagé, lié à un seul Pod |
| Cas d’utilisation	| Données persistantes, stockage partagé	| Données temporaires, cache, configurations locales |


En résumé, les **volumes éphémères** sont pratiques pour les données à court terme tandis que les **volumes** (surtout les PVs) servent au stockage persistant et partagé dans Kubernetes.