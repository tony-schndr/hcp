#!/bin/bash

source ./env

curl -X PUT "localhost:8443/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b?api-version=2.0" -H "Content-Type: application/json" -d '{"state":"Registered", "registrationDate": "now", "properties": { "tenantId": "64dc69e4-d083-49fc-9569-ebece1dd1408"}}'

DATA=$(cat <<EOF
{
  "properties": {
    "spec": {
      "version": {
        "id": "openshift-v4.17.0",
        "channelGroup": "stable"
      },
      "dns": {},
      "network": {
        "networkType": "OVNKubernetes",
        "podCidr": "10.128.0.0/14",
        "serviceCidr": "172.30.0.0/16",
        "machineCidr": "10.0.0.0/16",
        "hostPrefix": 23
      },
      "console": {},
      "api": {
        "visibility": "public"
      },
      "proxy": {},
      "platform": {
        "managedResourceGroup": "tschneid-hcp-mrg",
        "subnetId": "/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b/resourceGroups/${RESOURCEGROUP}/providers/Microsoft.Network/virtualNetworks/hcp-vnet/subnets/hcp-subnet",
        "outboundType": "loadBalancer",
        "networkSecurityGroupId": "/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b/resourceGroups/${RESOURCEGROUP}/providers/Microsoft.Network/networkSecurityGroups/${CUSTOMER_NSG}"
      },
      "externalAuth": {}
    }
  }
}
EOF
)

echo $DATA | curl -X PUT "localhost:8443/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b/resourceGroups/$RESOURCEGROUP/providers/Microsoft.RedHatOpenShift/hcpOpenShiftClusters/tschneid-hcp?api-version=2024-06-10-preview" \
  -L \
  -H "X-Ms-Arm-Resource-System-Data: {\"createdBy\": \"aro-hcp-local-testing\", \"createdByType\": \"User\", \"createdAt\": \"2024-06-06T19:26:56+00:00\"}" \
  -H "Content-Type: application/json" \
  -d @-

curl -X GET "localhost:8443/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b/resourceGroups/$RESOURCEGROUP/providers/Microsoft.RedHatOpenShift/hcpOpenShiftClusters/tschneid-hcp?api-version=2024-06-10-preview"
