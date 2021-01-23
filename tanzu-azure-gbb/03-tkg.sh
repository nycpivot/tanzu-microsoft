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
TYPE_SPEED=10

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

#TKG - DEPLOY APPS
DEMO_PROMPT="${GREEN}➜ TKG APPLY ${YELLOW}\W "

pe "kubectl config use-context tanzu-azure-aks-spring-music"

pe "cat deployment-spring-music.yaml"
pe "kubectl apply -f deployment-spring-music.yaml"
pe "kubectl get svc spring-music"

pe "kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core"

pe "cat deployment-aspnet-core.yaml"
pe "kubectl apply -f deployment-aspnet-core.yaml"
pe "kubectl get svc aspnet-core"

pe "kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-gke-aspnet-core"

pe "cat deployment-aspnet-core.yaml"
pe "kubectl apply -f deployment-aspnet-core.yaml"
pe "kubectl get svc aspnet-core"
