
export NAMESPACE=standard
export MANIFEST=./manifest

kubectl create ns $NAMESPACE

kubectl apply -f $MANIFEST/deployment.yaml -n $NAMESPACE