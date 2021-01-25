#CREATE TKG CLUSTER
sudo tkg delete cluster tanzu-azure-tkg-aspnet-core
sleep 15m

tkg get clusters
echo

read -p "PRESS ANY KEY TO CONTINUE: " ok
sudo tkg create cluster tanzu-azure-tkg-aspnet-core --plan prod
tkg get credentials tanzu-azure-tkg-aspnet-core
