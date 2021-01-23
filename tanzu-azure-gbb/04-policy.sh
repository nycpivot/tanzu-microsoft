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
TYPE_SPEED=15

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

DEMO_PROMPT="${GREEN}➜ TMC ${CYAN}\W "


#TMC POLICY

kubectl config use-context tanzu-azure-aks-spring-music

#-setup namespaces
pe "tmc cluster namespace create -f namespace-spring-web.yaml"
pe "tmc cluster namespace create -f namespace-spring-app.yaml"
pe "tmc cluster namespace create -f namespace-spring-data.yaml"
#VIEW IN PORTAL

pe "kubectl get ns"

#-image registry
cmd
pe "kubectl run nginx-app --image nginx -n spring-app"
kubectl get pods -n spring-app
cmd
pe "kubectl delete pod nginx-app -n spring-app"


pe "tmc organization image-policy create -f registry-nycpivot-policy.yaml" # -i --dry-run
#VIEW IN PORTAL

kubectl run nginx-app --image nginx -n spring-app
cmd

pe "tmc organization image-policy delete registry-nycpivot-policy"

echo
echo

#-network policy
kubectl run nginx-web --image nginx -n spring-web --labels app=spring-web
kubectl run nginx-data --image nginx -n spring-data
kubectl get pods -n spring-web
cmd
kubectl get pods -n spring-data -o wide
cmd

pe "kubectl exec nginx-web -it -n spring-web -- sh"
#curl ip

pe "tmc workspace network-policy create -f network-database-policy.yaml" # -i --dry-run

pe "kubectl exec nginx-web -it -n spring-web -- sh"
#curl ip





#-quota policy
pe "tmc clustergroup namespace-quota-policy create -f quota-development-policy.yaml" # -i --dry-run

pe "kubectl config use-context tanzu-azure-aks-spring-music"
pe "cat deployment-spring-music-quota.yaml"
pe "kubectl apply -f deployment-spring-music-quota.yaml"

echo
echo

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl apply -f deployment-spring-music-quota.yaml

echo
echo

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
kubectl apply -f deployment-spring-music-quota.yaml

echo
echo


#-security policy
pe "tmc clustergroup security-policy create -f security-production-policy.yaml" # -i --dry-run




