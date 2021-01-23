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

#TMC PORTAL - ATTACH AKS CLUSTER
DEMO_PROMPT="${GREEN}➜ TMC-AKS ${CYAN}\W "

pe "kubectl config use-context tanzu-azure-aks-spring-music"
pe "kubectl get ns"

#ATTACH AKS CLUSTER IN TMC PORTAL, GET THE LINK
#pe "tmc cluster attach --name tanzu-azure-aks-spring-music --cluster-group development"

pe "kubectl get ns"
