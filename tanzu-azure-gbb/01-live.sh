#!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=8

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear


#TBS
DEMO_PROMPT="${GREEN} TBS ${BLUE}\W "

pe "kubectl config use-context tanzu-build-service"

pe "kp image list"

#CREATE IMAGES NOW - DURING EXECUTION EXPLAIN COMMAND PARAMS, LIST ALL TARGET CLUSTERS, CHECK STATUS or CHECK BUILD LOGS
#pe "kp image create spring-music --tag tanzuregistry.azurecr.io/spring-music --git https://github.com/cloudfoundry-samples/spring-music.git"
#pe "kp image create aspnet-core --tag tanzuregistry.azurecr.io/aspnet-core --git https://github.com/nycpivot/dotnet-docker.git"

pe "kp image create aspnet-core-live --tag tanzuregistry.azurecr.io/aspnet-core-live --git https://github.com/nycpivot/dotnet-docker.git"

pe "kubectl config get-contexts --output name"

#CHECK STATUS OF IMAGES
#pe "kp image status spring-music"
#pe "kp build logs spring-music"

#pe "kp image status aspnet-core"
#kp build logs aspnet-core

pe "kp image status aspnet-core-live"


#TMC PORTAL - ATTACH AKS CLUSTER
DEMO_PROMPT="${GREEN} TMC-AKS ${CYAN}\W "

pe "kubectl config use-context tanzu-azure-aks-spring-music"
pe "kubectl get ns"

#pe "tmc cluster attach --name tanzu-azure-aks-spring-music --cluster-group development"

pe "kubectl get ns"


#TKG - DEPLOY APPS
DEMO_PROMPT="${GREEN} TKG-GKE-TKG ${YELLOW}\W "

pe "kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core"

pe "cat deployment-aspnet-core.yaml"
pe "kubectl apply -f deployment-aspnet-core.yaml"
pe "kubectl get svc tanzu-azure-gke-aspnet-core"

pe "kubectl config use-context tanzu-azure-tkg-aspnet-core"

pe "cat deployment-aspnet-core.yaml"
pe "kubectl apply -f deployment-aspnet-core.yaml"
pe "kubectl get svc tanzu-azure-gke-aspnet-core"


#TMC - CREATE POLICIES
#tmc clustergroup namespace-quota-policy create -r custom -i --cluster-group-name development --dry-run
pe "tmc clustergroup namespace-quota-policy create -f quota-development-policy.yaml"

#tmc clustergroup security-policy create -r custom -i --cluster-group-name production --dry-run
pe "tmc clustergroup security-policy create -f security-production-policy.yaml"


pe "kubectl run nginx --image nginx"
pe "kubectl delete pod nginx"
#tmc organization image-policy create -r custom -i --dry-run
pe "tmc organization image-policy create -f registry-nycpivot-policy.yaml"
pe "kubectl run nginx --image nginx"




