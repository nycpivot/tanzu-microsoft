#CREATE AKS CLUSTER
read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "ACR Server: " acr_server

sudo rm -rf .kube

az login -u $az_username -p $az_password
az account set --subscription PA-mjames

#-get tbs credentials
az aks get-credentials --name tanzu-build-service --resource-group tanzu-azure

#-spin up aks cluster
az aks delete --name tanzu-azure-aks-spring-music --resource-group tanzu-azure
az aks create --name tanzu-azure-aks-spring-music --resource-group tanzu-azure --node-count 3 \
	--attach-acr tanzuregistry --enable-addons monitoring \
	--network-plugin kubenet --network-policy calico \
	--generate-ssh-keys
az aks get-credentials --name tanzu-azure-aks-spring-music --resource-group tanzu-azure

acr_user=$(az acr credential show --name tanzuregistry --query username --output tsv)
acr_pass=$(az acr credential show --name tanzuregistry --query passwords[0].value --output tsv)

kubectl config use-context tanzu-azure-aks-spring-music

kubectl create secret docker-registry tanzuregistry-secret \
	--docker-server=${acr_server} \
	--docker-username=${acr_user} \
	--docker-password=${acr_pass} \
	--docker-email=mijames@vmware.com

#CREATE GKE CLUSTER
gcloud auth login

gcloud config set project pa-mjames
gcloud container clusters delete "tanzu-azure-gke-aspnet-core" --region "us-east1"
gcloud container clusters create "tanzu-azure-gke-aspnet-core" --region "us-east1" --no-enable-basic-auth --cluster-version "1.16.15-gke.6000" --release-channel "None" --machine-type "e2-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/pa-mjames/global/networks/default" --subnetwork "projects/pa-mjames/regions/us-east1/subnetworks/default" --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0
gcloud container clusters get-credentials "tanzu-azure-gke-aspnet-core" --region "us-east1"

kubectl config use-context tanzu-azure-gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core

kubectl create secret docker-registry tanzuregistry-secret \
	--docker-server=${acr_server} \
	--docker-username=${acr_user} \
	--docker-password=${acr_pass} \
	--docker-email=mijames@vmware.com
	

#CREATE TKG CLUSTER
sudo tkg delete cluster tanzu-azure-tkg-aspnet-core
sleep 15m

tkg get clusters
read -p "PRESS ANY KEY TO CONTINUE" ok

sudo tkg create cluster tanzu-azure-tkg-aspnet-core --plan prod
tkg get credentials tanzu-azure-tkg-aspnet-core

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core

kubectl create secret docker-registry tanzuregistry-secret \
	--docker-server=${acr_server} \
	--docker-username=${acr_user} \
	--docker-password=${acr_pass} \
	--docker-email=mijames@vmware.com


#DELETE KP IMAGES
kubectl config use-context tanzu-build-service
kp image delete spring-music
kp image delete aspnet-core


#TMC - TKG, GKE
tmc clustergroup namespace-quota-policy delete quota-development-policy --cluster-group-name development
tmc clustergroup security-policy delete security-production-policy --cluster-group-name production
tmc workspace network-policy delete network-database-policy --workspace-name database
tmc organization image-policy delete registry-nycpivot-policy


read -p "tmc tanzu-azure-tkg-aspnet-core attach url: " tkg_attach_url

kubectl config use-context tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core
$tkg_attach_url

sleep 5m

read -p "tmc tanzu-azure-gke-aspnet-core attach url: " gke_attach_url

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
$gke_attach_url

sleep 5m


#DOWNLOAD FILES
rm deployment-aspnet-core.yaml
rm deployment-spring-music.yaml
rm deployment-spring-music-quota.yaml
rm deployment-spring-music-security.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-aspnet-core.yaml
#wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-aspnet-core-registry.yaml
#wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-aspnet-core-network.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-spring-music.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-spring-music-quota.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-spring-music-security.yaml

rm network-web-policy.yaml
rm quota-development-policy.yaml
rm registry-nycpivot-policy.yaml
rm security-production-policy.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/policies/network-web-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/policies/quota-development-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/policies/registry-nycpivot-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/policies/security-production-policy.yaml
