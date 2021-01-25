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

#-show registry and clusters while images are built
DEMO_PROMPT="${GREEN}➜ ACR ${CYAN}\W "
pe "az acr repository list -n tanzuregistry"
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

pe "kp image list"
echo

pe "kubectl config use-context tanzu-azure-aks-spring-music"
DEMO_PROMPT="${GREEN}➜ AKS ${CYAN}\W "
echo

pe "kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core"
DEMO_PROMPT="${GREEN}➜ GKE ${CYAN}\W "
echo

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
DEMO_PROMPT="${GREEN}➜ TKG ${CYAN}\W "
echo

echo "DELETE CLUSTERS IN TMC PORTAL

