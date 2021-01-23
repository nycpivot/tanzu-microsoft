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
DEMO_PROMPT="${GREEN}➜ APPLY AKS ${CYAN}\W "

pe "cat deployment-spring-music.yaml"
echo
echo
pe "kubectl apply -f deployment-spring-music.yaml"


pe "kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core"
DEMO_PROMPT="${GREEN}➜ APPLY GKE ${CYAN}\W "

pe "kubectl apply -f deployment-aspnet-core.yaml"


pe "kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core"
DEMO_PROMPT="${GREEN}➜ APPLY TKG ${CYAN}\W "

pe "kubectl apply -f deployment-aspnet-core.yaml"


DEMO_PROMPT="${COLOR_RESET}➜ APPLY TKG ${CYAN}\W "

kubectl config use-context tanzu-azure-aks-spring-music
kubectl get svc spring-music

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl get svc aspnet-core

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
kubectl get svc aspnet-core
