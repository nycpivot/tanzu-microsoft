#CREATE AKS CLUSTER
read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "Azure Subscription: " subscription
read -p "Azure Resource Group: " group
read -p "AKS Cluster Name (tanzu-azure-aks-spring-music): " cluster
read -p "ACR Registry Name (tanzuregistry): " registry

az login -u $az_username -p $az_password
az account set --subscription $subscription

az aks create --name $cluster --resource-group $group --node-count 3 \
	--attach-acr $registry --enable-addons monitoring \
	--network-plugin kubenet --network-policy calico \
	--generate-ssh-keys

az aks get-credentials --name $cluster --resource-group $group


#CREATE TKG CLUSTER
sudo tkg create cluster tanzu-azure-tkg-aspnet-core --plan prod
tkg get credentials tanzu-azure-tkg-aspnet-core-admin@tanzu-azure-tkg-aspnet-core


#CREATE GKE CLUSTER
gcloud auth login

read -p "Logging into GCP..." var1

gcloud config set project pa-mjames
gcloud container clusters create "tanzu-azure-gke-aspnet-core" --region "us-east1" --no-enable-basic-auth --cluster-version "1.16.15-gke.6000" --release-channel "None" --machine-type "e2-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/pa-mjames/global/networks/default" --subnetwork "projects/pa-mjames/regions/us-east1/subnetworks/default" --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0


wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-aspnet-core.yaml
#wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-aspnet-core-registry.yaml
#wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-aspnet-core-network.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-spring-music.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-spring-music-quota.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-microsoft/main/tanzu-azure-gbb/deployment-spring-music-security.yaml
