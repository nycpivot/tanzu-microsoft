read -p "Azure Username: " az_user
read -p "Azure Password: " az_pass
read -p "Azure Subscription: " subscription
read -p "ACR Server: " acr_server

az login -u $az_user -p az_pass
az account set --subscription $subscription

acr_user=$(az acr credential show --name $registry --query username --output tsv)
acr_pass=$(az acr credential show --name $registry --query passwords[0].value --output tsv)

kubectl create secret tanzuregistry tanzuregistry-secret \
	--docker-server=${acr_server} \
	--docker-username=${acr_user} \
	--docker-password=${acr_pass} \
	--docker-email=mijames@vmware.com