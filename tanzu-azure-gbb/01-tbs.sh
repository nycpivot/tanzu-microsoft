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
TYPE_SPEED=18

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

DEMO_PROMPT="${GREEN}➜ ACR ${CYAN}\W "
pe "pe az acr repository list -n tanzuregistry"
echo

#TBS
DEMO_PROMPT="${GREEN}➜ TBS ${CYAN}\W "

pe "kubectl config use-context tanzu-build-service"
echo


DEMO_PROMPT="${GREEN}➜ TKG ${CYAN}\W "
pe "tkg get clusters"
echo

DEMO_PROMPT="${GREEN}➜ AKS ${CYAN}\W "
pe "az aks list -g tanzu-azure --query '[].{name:name, k8s:kubernetesVersion}' --output table"
echo

DEMO_PROMPT="${GREEN}➜ GKE ${CYAN}\W "
pe "gcloud container clusters list --region us-east1 --format='table(name,master_version())'"
echo

DEMO_PROMPT="${GREEN}➜ ACR ${CYAN}\W "
pe "pe az acr repository list -n tanzuregistry"
echo

#TBS
DEMO_PROMPT="${GREEN}➜ TBS ${CYAN}\W "

pe "kubectl config use-context tanzu-build-service"
echo

pe "kp image list"
echo

#CREATE IMAGES NOW - DURING EXECUTION EXPLAIN COMMAND PARAMS, LIST ALL TARGET CLUSTERS, CHECK STATUS or CHECK BUILD LOGS
pe "kp image create spring-music --tag tanzuregistry.azurecr.io/spring-music --git https://github.com/cloudfoundry-samples/spring-music.git"
pe "kp image create aspnet-core --tag tanzuregistry.azurecr.io/aspnet-core --git https://github.com/nycpivot/dotnet-docker.git"
echo

pe "kp image status spring-music"
echo

pe "kp image status aspnet-core"
echo

pe "kp build logs spring-music"
echo

pe "kp image list"
echo
