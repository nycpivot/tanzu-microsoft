#INTRO
kubectl config use-context tanzu-build-service

tkg get clusters

kp image list


#TANZU BUILD SERVICE
kp image create spring-music --tag tanzuregistry.azurecr.io/spring-music --git https://github.com/cloudfoundry-samples/spring-music.git

kp image status spring-music
#kp build logs spring-music


#AKS
kubectl config use-context tanzu-azure-aks-spring-music

cat deployment.yaml
kubectl apply -f deployment.yaml

#kubectl set image deployment tbs-deployment tbs-core-web-mvc=${acrserver}/tbs-core-web-mvc:latest





kp image create aspnet-core --tag tanzuregistry.azurecr.io/aspnet-core --git https://github.com/nycpivot/tanzu-build-service.git


kp image create dotnet-core --tag tanzuregistry.azurecr.io/dotnet-core --git https://github.com/nycpivot/dotnet-docker.git