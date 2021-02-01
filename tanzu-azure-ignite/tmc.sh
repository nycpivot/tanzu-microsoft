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

DEMO_PROMPT="${GREEN}➜ TMC ${CYAN}\W "

#TMC PORTAL - ATTACH AKS CLUSTER
pe "kubectl get ns"
echo

#-pull from tanzuregistry
pe "kubectl run spring-music --image tanzuregistry.azurecr.io/spring-music -n ignite-demo"
echo

#-image registry
pe "kubectl run nginx --image nginx -n ignite-demo"
echo
