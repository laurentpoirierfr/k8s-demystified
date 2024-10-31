export HELM_REPO=./charts

helm lint ${HELM_REPO}/*

helm package ${HELM_REPO}/* --destination ./generated

