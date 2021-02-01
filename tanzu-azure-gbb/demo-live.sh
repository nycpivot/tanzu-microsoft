#OPEN TWO TERMINALS


#PRE-DEMO - TBS
kubectl config use-context tanzu-build-service

kp image list

#CREATE IMAGES NOW - DURING EXECUTION EXPLAIN COMMAND PARAMS, LIST ALL TARGET CLUSTERS, CHECK STATUS or CHECK BUILD LOGS
kp image create spring-music --tag tanzuregistry.azurecr.io/spring-music --git https://github.com/cloudfoundry-samples/spring-music.git
kp image create aspnet-core --tag tanzuregistry.azurecr.io/aspnet-core --git https://github.com/nycpivot/dotnet-docker.git

kubectl config get-contexts

#CHECK STATUS OF IMAGES
kp image status spring-music
kp build logs spring-music

kp image status aspnet-core
kp build logs aspnet-core



#PRE-DEMO - TMC - ATTACH CLUSTERS
read -p "tmc tanzu-azure-aks-spring-music attach url: " aks_attach_url

kubectl config use-context tanzu-azure-aks-spring-music
kubectl create -f $aks_attach_url

#kubectl apply -f deployment-spring-music-quota.yaml


read -p "tmc tanzu-azure-gke-aspnet-core attach url: " gke_attach_url

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl create -f $gke_attach_url

#kubectl apply -f deployment-spring-music-quota.yaml


read -p "Setup tanzu-azure-tkg-aspnet-core in portal" ok









#PRE-DEMO - TKG

#AKS - SPRING-MUSIC
kubectl config use-context tanzu-azure-aks-spring-music

cat deployment-spring-music.yaml
kubectl apply -f deployment-spring-music.yaml



#GKE - SPRING-MUSIC
kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core

cat deployment-aspnet-core.yaml
kubectl apply -f deployment-aspnet-core.yaml



#TKG - ASPNET-CORE
kubectl config use-context tanzu-azure-tkg-spring-music

cat deployment-aspnet-core.yaml
kubectl apply -f deployment-aspnet-core.yaml



#kubectl set image deployment tbs-deployment tbs-core-web-mvc=${acrserver}/tbs-core-web-mvc:latest
