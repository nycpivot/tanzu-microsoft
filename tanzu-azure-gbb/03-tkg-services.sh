kubectl config use-context tanzu-azure-aks-spring-music
kubectl get svc spring-music
echo

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl get svc aspnet-core
echo

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
kubectl get svc aspnet-core
echo