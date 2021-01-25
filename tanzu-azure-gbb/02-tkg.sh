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
TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

#TKG - DEPLOY APPS
pe "kubectl config use-context tanzu-azure-aks-spring-music"
DEMO_PROMPT="${GREEN}➜ AKS ${CYAN}\W "
echo

pe "cat deployment-spring-music.yaml"
echo

pe "clear"

pe "kubectl apply -f deployment-spring-music.yaml"
echo

pe "kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core"
DEMO_PROMPT="${GREEN}➜ GKE ${CYAN}\W "
echo

pe "kubectl apply -f deployment-aspnet-core.yaml"
echo

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
DEMO_PROMPT="${GREEN}➜ TKG ${CYAN}\W "
echo

pe "kubectl apply -f deployment-aspnet-core.yaml"
echo

pe "clear"


kubectl config use-context tanzu-azure-aks-spring-music
kubectl get svc spring-music
echo

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl get svc aspnet-core
echo

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
kubectl get svc aspnet-core
echo
