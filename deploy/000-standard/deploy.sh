
export NAMESPACE=standard
export MANIFEST=./manifest

kubectl create ns $NAMESPACE

kubectl apply -f $MANIFEST/deployment.yaml -n $NAMESPACE

kubectl apply -f $MANIFEST/service.yaml -n $NAMESPACE

# kubectl apply -f $MANIFEST/ingress.yaml -n $NAMESPACE