#!/bin/bash

# This script will add multiple outbound IPs to the hosted clusters loadbalancer enabling more than 62 nodes.
# 1. Create desired public IPs
# 2. Create frontend IPs on loadbalancer
# 3. Add frontend IPs to outbound rule.

# Location the hosted cluster is deployed to
LOCATION=
# Name of the hosted clusters managed resource gruop
MANAGED_RG=
NUM_OF_IPS=3 # 3 IPs allow for 3 * 62 nodes
PREFIX="outbound-ip"
LOAD_BALANCER_NAME=$(az network lb list --resource-group $MANAGED_RG --query "[0].name" -o tsv)
OUTBOUND_RULE=$(az network lb list --resource-group $MANAGED_RG --query "[0].outboundRules[0].name" -o tsv)

echo  "Adding outbound IPs to loadbalancer $LOAD_BALANCER_NAME"

for i in $(seq 1 $NUM_OF_IPS); do
  PIP_RESOURCE_ID=$(az network public-ip create \
  --resource-group $MANAGED_RG \
  --name "${PREFIX}-${i}" \
  --location $LOCATION \
  --sku Standard \
  --allocation-method Static \
  --query "publicIp.id" -o tsv)
  echo "Created Public IP: ${PREFIX}-${i}"

  FRONTEND_IP_ID=$(az network lb frontend-ip create \
    --resource-group $MANAGED_RG \
    --lb-name $LOAD_BALANCER_NAME \
    --name ${PREFIX}-${i} \
    --public-ip-address $PIP_RESOURCE_ID \
    --query "id" -o tsv)

  az network lb outbound-rule update \
    --resource-group $MANAGED_RG \
    --lb-name $LOAD_BALANCER_NAME \
    --name $OUTBOUND_RULE \
    --add frontendIpConfigurations id=$FRONTEND_IP_ID
done

