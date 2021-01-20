#OPEN TWO TERMINALS


#PRE-DEMO - TBS
kubectl config use-context tanzu-build-service

kp image list

#CREATE IMAGES NOW - DURING EXECUTION EXPLAIN COMMAND PARAMS, LIST ALL TARGET CLUSTERS, CHECK STATUS or CHECK BUILD LOGS
kp image create spring-music --tag tanzuregistry.azurecr.io/spring-music --git https://github.com/cloudfoundry-samples/spring-music.git
kp image create aspnet-core --tag tanzuregistry.azurecr.io/aspnet-core --git https://github.com/nycpivot/dotnet-docker.git

#TKG
tkg get clusters

#AKS
#az login 
az aks list --query "[?resourceGroup=='tanzu-azure'].{name:name, state:provisioningState, k8s:kubernetesVersion}" --output table

#GKE
#gcloud auth login
gcloud config set project pa-mjames
gcloud container clusters list

kp image status spring-music
kp build logs spring-music

kp image status aspnet-core
kp build logs aspnet-core



#PRE-DEMO - TMC - ATTACH CLUSTERS
kubectl config use-context tanzu-azure-aks-spring-music
kubectl create -f "https://nycpivot.tmc.cloud.vmware.com/installer?id=688fc86507993ab69a37ece187c72887224ec74999b46494b37c96a42fe279cc&source=attach"

#QUOTA POLICY
kubectl apply -f deployment-spring-music-quota.yaml

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl create -f "https://nycpivot.tmc.cloud.vmware.com/installer?id=1ad1b30df5d392e67cbf80cbfd3ad579604ccff1e07c6db973514cd9b0024422&source=attach"

kubectl apply -f deployment-spring-music-quota.yaml


#ATTACH TKG
kubectl config use-context tanzu-azure-tkg-spring-music-admin@tanzu-azure-tkg-aspnet-core
kubectl create -f "https://nycpivot.tmc.cloud.vmware.com/installer?id=c8b409e634e7ac8910b947dc085d332d93ee2a2f4a481d3f2912dbecbcf6910b&source=attach"











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
