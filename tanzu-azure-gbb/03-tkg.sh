#TKG - DEPLOY APPS
DEMO_PROMPT="${GREEN}➜ APPLY ${YELLOW}\W "

pe "kubectl config use-context tanzu-azure-aks-spring-music"

pe "cat deployment-spring-music.yaml"
pe "kubectl apply -f deployment-spring-music.yaml"
pe "kubectl get svc tanzu-azure-aks-spring-music"

pe "kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core"

pe "cat deployment-aspnet-core.yaml"
pe "kubectl apply -f deployment-aspnet-core.yaml"
pe "kubectl get svc tanzu-azure-gke-aspnet-core"

pe "kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-gke-aspnet-core"

pe "cat deployment-aspnet-core.yaml"
pe "kubectl apply -f deployment-aspnet-core.yaml"
pe "kubectl get svc tanzu-azure-tkg-aspnet-core"
