#TMC PORTAL - ATTACH AKS CLUSTER
DEMO_PROMPT="${GREEN}➜ TMC-AKS ${CYAN}\W "

pe "kubectl config use-context tanzu-azure-aks-spring-music"
pe "kubectl get ns"

#ATTACH AKS CLUSTER IN TMC PORTAL, GET THE LINK
#pe "tmc cluster attach --name tanzu-azure-aks-spring-music --cluster-group development"

pe "kubectl get ns"
