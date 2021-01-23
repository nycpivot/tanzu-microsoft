#TMC - CREATE POLICIES
#tmc clustergroup namespace-quota-policy create -r custom -i --cluster-group-name development --dry-run
pe "tmc clustergroup namespace-quota-policy create -f quota-development-policy.yaml"

#tmc clustergroup security-policy create -r custom -i --cluster-group-name production --dry-run
pe "tmc clustergroup security-policy create -f security-production-policy.yaml"


pe "kubectl run nginx --image nginx"
pe "kubectl delete pod nginx"
#tmc organization image-policy create -r custom -i --dry-run
pe "tmc organization image-policy create -f registry-nycpivot-policy.yaml"
pe "kubectl run nginx --image nginx"