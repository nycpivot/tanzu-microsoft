#CREATE AKS CLUSTER
read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "Azure Subscription: " subscription
read -p "Azure Resource Group: " group
read -p "AKS Cluster Name (tanzu-azure-aks-spring-music): " cluster
read -p "ACR Registry Name (tanzuregistry): " registry

az login -u $az_username -p $az_password
az account set --subscription $subscription

az aks delete --name $cluster --resource-group $group

az aks create --name $cluster --resource-group $group --node-count 3 \
	--attach-acr $registry --enable-addons monitoring \
	--network-plugin kubenet --network-policy calico \
	--generate-ssh-keys

az aks get-credentials --name $cluster --resource-group $group


#CREATE TKG CLUSTER
sudo tkg delete cluster tanzu-azure-tkg-aspnet-core
read -p "Deleting cluster..."

sudo tkg create cluster tanzu-azure-tkg-aspnet-core --plan prod
tkg get credentials tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core


#CREATE GKE CLUSTER
gcloud auth login

read -p "WAITING FOR TOKEN..." var1

gcloud config set project pa-mjames
gcloud container clusters delete "tanzu-azure-gke-aspnet-core" --region "us-east1"
gcloud container clusters create "tanzu-azure-gke-aspnet-core" --region "us-east1" --no-enable-basic-auth --cluster-version "1.16.15-gke.6000" --release-channel "None" --machine-type "e2-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/pa-mjames/global/networks/default" --subnetwork "projects/pa-mjames/regions/us-east1/subnetworks/default" --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0
gcloud container clusters get-credentials "tanzu-azure-gke-aspnet-core" --region "us-east1"

#DELETE KP IMAGES
kubectl config use-context tanzu-build-service
kp image delete spring-music
kp image delete aspnet-core


#TMC
tmc clustergroup namespace-quota-policy delete quota-development-policy --cluster-group-name development
tmc clustergroup security-policy delete security-production-policy --cluster-group-name production
#tmc workspace network-policy delete network-database-policy --workspace-name database
tmc organization image-policy delete registry-nycpivot-policy


read -p "tmc tanzu-azure-tkg-spring-music attach url: " tkg_attach_url

kubectl config use-context tanzu-azure-tkg-spring-music
kubectl create -f $tkg_attach_url

read -p "tmc tanzu-azure-gke-aspnet-core attach url: " gke_attach_url

kubectl config use-context gke_pa-mjames_us-east1_tanzu-azure-gke-aspnet-core
kubectl create -f $gke_attach_url




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
