#!/bin/bash

export RESOURCEGROUP=tschneid-hcp-1
export LOCATION=eastus

curl -X DELETE "localhost:8443/subscriptions/1d3378d3-5a3f-4712-85a1-2485495dfc4b/resourceGroups/$RESOURCEGROUP/providers/Microsoft.RedHatOpenShift/hcpOpenShiftClusters/tschneid-hcp?api-version=2024-06-10-preview"
