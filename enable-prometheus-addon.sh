#!/bin/bash

SUBSCRIPTION_ID="1d3378d3-5a3f-4712-85a1-2485495dfc4b"
RESOURCE_GROUP="aro-hcp-svc-cluster-tschneid"
AMW_RESOURCE_GROUP=hcp-metrics-tschneid
LOCATION="westus3"
CLUSTER_NAME=$(az deployment group show -g aro-hcp-svc-cluster-tschneid -n aro-hcp-svc-cluster-tschneid --query properties.outputs.aksClusterName.value -o tsv)
AMW_NAME="aro-hcp-monitor"
GRAFANA_NAME="aro-hcp-grafana"
GRAFANA_ADMIN_OBJECT_ID=$(az deployment group show -g hcp-metrics-tschneid -n Metrics --query properties.outputs.grafanaIdentityPrincipalId.value -o tsv)

rm -rf work/
mkdir -p work/

cp -R prometheus-collector/AddonBicepTemplate/ work/

jq --arg sub_id "$SUBSCRIPTION_ID" \
   --arg rg_name "$RESOURCE_GROUP" \
   --arg amw_name "$AMW_NAME" \
   --arg amw_rg_name "$AMW_RESOURCE_GROUP" \
   --arg amw_location "$LOCATION" \
   --arg cluster_name "$CLUSTER_NAME" \
   --arg cluster_location "$LOCATION" \
   --arg grafana_location "$LOCATION" \
   --arg grafana_admin_object_id "$GRAFANA_ADMIN_OBJECT_ID" \
   '.parameters.azureMonitorWorkspaceResourceId.value |= gsub("\\{sub_id\\}"; $sub_id) |
    .parameters.azureMonitorWorkspaceResourceId.value |= gsub("\\{rg_name\\}"; $amw_rg_name) |
    .parameters.azureMonitorWorkspaceResourceId.value |= gsub("\\{amw_name\\}"; $amw_name) |
    .parameters.azureMonitorWorkspaceLocation.value |= gsub("\\{amwLocation\\}"; $amw_location) |
    .parameters.clusterResourceId.value |= gsub("\\{sub_id\\}"; $sub_id) |
    .parameters.clusterResourceId.value |= gsub("\\{rg_name\\}"; $rg_name) |
    .parameters.clusterResourceId.value |= gsub("\\{cluster_name\\}"; $cluster_name) |
    .parameters.clusterLocation.value |= gsub("\\{clusterLocation\\}"; $cluster_location) |
    .parameters.grafanaResourceId.value |= gsub("\\{sub_id\\}"; $sub_id) |
    .parameters.grafanaResourceId.value |= gsub("\\{rg_name\\}"; $amw_rg_name) |
    .parameters.grafanaResourceId.value |= gsub("\\{cluster_name\\}"; $cluster_name) |
    .parameters.grafanaLocation.value |= gsub("\\{grafanaLocation\\}"; $grafana_location) |
    .parameters.grafanaAdminObjectId.value |= gsub("\\{grafanaAdminObjectId\\}"; $grafana_admin_object_id)' \
   work/AddonBicepTemplate/FullAzureMonitorMetricsProfileParameters.json > work/AddonBicepTemplate/tmp.json && \
   mv work/AddonBicepTemplate/tmp.json work/AddonBicepTemplate/FullAzureMonitorMetricsProfileParameters.json

# az deployment group create --template-file work/AddonBicepTemplate/FullAzureMonitorMetricsProfile.bicep -g $AMW_RESOURCE_GROUP --parameters work/AddonBicepTemplate/FullAzureMonitorMetricsProfileParameters.json

az deployment group create -g $AMW_RESOURCE_GROUP -n aks-prometheus-addon --template-file ./work/AddonBicepTemplate/FullAzureMonitorMetricsProfile.bicep --parameters ./work/AddonBicepTemplate/FullAzureMonitorMetricsProfileParameters.json
