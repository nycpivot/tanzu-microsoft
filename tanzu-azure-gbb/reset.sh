#TANZU BUILD SERVICE
kubectl config use-context tanzu-build-service

kp image delete spring-music
kp image delete aspnet-core


#AKS
read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "Azure Subscription: " subscription
read -p "Azure Resource Group: " group
read -p "AKS Cluster Name (tanzu-azure-aks-spring-music): " cluster

az login -u $az_username -p $az_password
az account set --subscription $subscription

az aks delete --name $cluster --resource-group $group

#TKG
sudo tkg delete cluster tanzu-azure-tkg-aspnet-core

#GKE
gcloud auth login

read -p "Logging into GCP..." var1

gcloud config set project pa-mjames
gcloud container clusters delete "tanzu-azure-gke-aspnet-core" --region "us-east1"
