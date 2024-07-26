resource monitor 'microsoft.monitor/accounts@2021-06-03-preview' = {
  name: 'aro-hcp-monitor'
  location: resourceGroup().location
}

resource grafana 'Microsoft.Dashboard/grafana@2023-09-01' = {
  name: 'aro-hcp-grafana'
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    grafanaIntegrations: {
      azureMonitorWorkspaceIntegrations: [
        {
          azureMonitorWorkspaceResourceId: monitor.id
        }
      ]
    }
  }
}

output  grafanaIdentityPrincipalId string = grafana.identity.principalId
// Assign the Monitoring Data Reader role to the Azure Managed Grafana system-assigned managed identity at the workspace scope
var dataReader = 'b0d8363b-8ddd-447d-831f-62ca05bff136'

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(monitor.id, grafana.id, dataReader)
  scope: monitor
  properties: {
    principalId: grafana.identity.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', dataReader)
  }
}

module alerts 'Alerts.bicep' = {
  name: 'alerts'
  params: {
    azureMonitoring: monitor.id
  }
}
