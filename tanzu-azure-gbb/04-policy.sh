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

DEMO_PROMPT="${GREEN}➜ TMC POLICY ${YELLOW}\W "


#TMC POLICY

#-image registry
pe "kubectl run nginx --image nginx"
pe "kubectl get pods"
pe "kubectl delete pod nginx"
#tmc organization image-policy create -r custom -i --dry-run
pe "tmc organization image-policy create -f registry-nycpivot-policy.yaml"
pe "kubectl run nginx --image nginx"


#-quota policy
#tmc clustergroup namespace-quota-policy create -r custom -i --cluster-group-name development --dry-run
pe "tmc clustergroup namespace-quota-policy create -f quota-development-policy.yaml"


#-network policy
#tmc clustergroup security-policy create -r custom -i --cluster-group-name production --dry-run
pe "tmc clustergroup security-policy create -f security-production-policy.yaml"


