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
TYPE_SPEED=12

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

#TMC PORTAL - ATTACH AKS CLUSTER
pe "kubectl config use-context tanzu-azure-aks-spring-music"
DEMO_PROMPT="${GREEN}➜ AKS ${CYAN}\W "

pe "kubectl get ns"
echo

cmd

#ATTACH AKS CLUSTER IN TMC PORTAL, GET THE LINK
#pe "tmc cluster attach --name tanzu-azure-aks-spring-music --cluster-group development"

pe "kubectl get ns"
echo

pe "clear"

DEMO_PROMPT="${GREEN}➜ TMC ${CYAN}\W "

#-setup namespaces
pe "tmc cluster namespace create -f namespace-spring-web.yaml"
pe "tmc cluster namespace create -f namespace-spring-app.yaml"
pe "tmc cluster namespace create -f namespace-spring-data.yaml"
echo

#-image registry
pe "kubectl run nginx-app --image nginx -n spring-app"
kubectl get pods -n spring-app
echo
cmd
echo

pe "kubectl delete pod nginx-app -n spring-app"
echo

pe "tmc organization image-policy create -f registry-nycpivot-policy.yaml" # -i --dry-run
echo

pe "kubectl run nginx-app --image nginx -n spring-app"
echo

#-quota
pe "tmc clustergroup namespace-quota-policy create -f quota-development-policy.yaml" # -i --dry-run
echo

pe "kubectl run nginx --image nginx --requests 'cpu=500m,memory=128Gi' --limits 'cpu=750m,memory=512Gi'"
echo

#pe "kubectl run nginx --image nginx --requests 'cpu=200m,memory=1Gi' --limits 'cpu=250m,memory=1Gi'"
#echo
