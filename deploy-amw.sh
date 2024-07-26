#!/bin/bash

# This script deploys the Azure Monitor Workspace.
# The templates should be replaced by ACR in the future.

az group create -n hcp-metrics-$USER -l westus3
# Metrics.bicep -> https://msazure.visualstudio.com/AzureRedHatOpenShift/_git/ARO-Pipelines?path=/metrics/infra/Templates/Metrics.bicep
# Also needs Alerts.bicep
az deployment group create --template-file Metrics.bicep -g hcp-metrics-$USER 


