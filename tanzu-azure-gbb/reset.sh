#TANZU BUILD SERVICE
kubectl config use-context tanzu-build-service

kp image delete spring-music
kp image delete aspnet-core


#TANZU KUBERNETES GRID CLUSTERS
kubectl config use-context tanzu-azure-aks-spring-music
kubectl delete ns vmware-system-tmc
kubectl delete deployment spring-music
kubectl delete svc spring-music
kubectl delete deployment spring-music-quota
kubectl delete deployment spring-music-security

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl delete ns vmware-system-tmc
kubectl delete deployment aspnet-core
kubectl delete svc aspnet-core
kubectl delete deployment aspnet-core-quota
kubectl delete deployment aspnet-core-security

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
kubectl delete ns vmware-system-tmc
kubectl delete deployment aspnet-core
kubectl delete svc aspnet-core
kubectl delete deployment aspnet-core-quota
kubectl delete deployment aspnet-core-security
