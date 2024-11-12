export CUSTOMER_RG_NAME="tschneid-hcp-1"
export CUSTOMER_VNET_NAME="hcp-vnet"
export CUSTOMER_VNET_SUBNET1="hcp-subnet"
export CUSTOMER_NSG="hcp-nsg-1"
export LOCATION="eastus"

az group create --name "${CUSTOMER_RG_NAME}" --location ${LOCATION}

az network nsg create --resource-group ${CUSTOMER_RG_NAME} --name ${CUSTOMER_NSG} --location ${LOCATION}
GetNsgID=$(az network nsg list --query "[?name=='${CUSTOMER_NSG}'].id" -o tsv)

az network vnet create \
  --name ${CUSTOMER_VNET_NAME} \
  --resource-group ${CUSTOMER_RG_NAME} \
  --address-prefix 10.0.0.0/16 \
  --subnet-name ${CUSTOMER_VNET_SUBNET1} \
  --subnet-prefixes 10.0.0.0/24 \
  --nsg "${GetNsgID}"  --location ${LOCATION}
