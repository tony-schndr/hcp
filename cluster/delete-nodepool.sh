#!/bin/bash

RESOURCEGROUP=tschneid-hcp-1
LOCATION=eastus

curl -X DELETE "localhost:8443/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b/resourceGroups/$RESOURCEGROUP/providers/Microsoft.RedHatOpenShift/hcpOpenShiftClusters/tschneid-hcp/nodePools/dev-nodepool?api-version=2024-06-10-preview"
