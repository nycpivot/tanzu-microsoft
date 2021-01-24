#CREATE TKG CLUSTER
sudo tkg delete cluster tanzu-azure-tkg-aspnet-core
sleep 15m

tkg get clusters

sudo tkg create cluster tanzu-azure-tkg-aspnet-core --plan prod
tkg get credentials tanzu-azure-tkg-aspnet-core
