# VPN Gateways `[Microsoft.Network/vpnGateways]`

This module deploys VPN Gateways.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Deployment examples](#Deployment-examples)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2017-04-01](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2017-04-01/locks) |
| `Microsoft.Network/vpnGateways` | [2021-05-01](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Network/2021-05-01/vpnGateways) |
| `Microsoft.Network/vpnGateways/natRules` | [2021-05-01](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Network/2021-05-01/vpnGateways/natRules) |
| `Microsoft.Network/vpnGateways/vpnConnections` | [2021-05-01](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Network/2021-05-01/vpnGateways/vpnConnections) |

## Parameters

**Required parameters**
| Parameter Name | Type | Description |
| :-- | :-- | :-- |
| `name` | string | Name of the VPN gateway. |
| `virtualHubResourceId` | string | The resource ID of a virtual Hub to connect to. Note: The virtual Hub and Gateway must be deployed into the same location. |

**Optional parameters**
| Parameter Name | Type | Default Value | Allowed Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `bgpSettings` | object | `{object}` |  | BGP settings details. |
| `connections` | _[connections](connections/readme.md)_ array | `[]` |  | The connections to create in the VPN gateway. |
| `enableBgpRouteTranslationForNat` | bool | `False` |  | Enable BGP routes translation for NAT on this VPN gateway. |
| `enableDefaultTelemetry` | bool | `True` |  | Enable telemetry via the Customer Usage Attribution ID (GUID). |
| `isRoutingPreferenceInternet` | bool | `False` |  | Enable routing preference property for the public IP interface of the VPN gateway. |
| `location` | string | `[resourceGroup().location]` |  | Location where all resources will be created. |
| `lock` | string | `''` | `[, CanNotDelete, ReadOnly]` | Specify the type of lock. |
| `natRules` | _[natRules](natRules/readme.md)_ array | `[]` |  | List of all the NAT Rules to associate with the gateway. |
| `tags` | object | `{object}` |  | Tags of the resource. |
| `vpnGatewayScaleUnit` | int | `2` |  | The scale unit for this VPN gateway. |


### Parameter Usage: `bgpSettings`

<details>

<summary>Parameter JSON format</summary>

```json
"bgpSettings": {
    "asn": 65515,
    "peerWeight": 0,
    "bgpPeeringAddresses": [
        {
            "ipconfigurationId": "Instance0",
            "defaultBgpIpAddresses": [
                "10.0.0.12"
            ],
            "customBgpIpAddresses": [],
            "tunnelIpAddresses": [
                "20.84.35.53",
                "10.0.0.4"
            ]
        },
        {
            "ipconfigurationId": "Instance1",
            "defaultBgpIpAddresses": [
                "10.0.0.13"
            ],
            "customBgpIpAddresses": [],
            "tunnelIpAddresses": [
                "20.84.34.225",
                "10.0.0.5"
            ]
        }
    ]
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
bgpSettings: {
    asn: 65515
    peerWeight: 0
    bgpPeeringAddresses: [
        {
            ipconfigurationId: 'Instance0'
            defaultBgpIpAddresses: [
                '10.0.0.12'
            ]
            customBgpIpAddresses: []
            tunnelIpAddresses: [
                '20.84.35.53'
                '10.0.0.4'
            ]
        }
        {
            ipconfigurationId: 'Instance1'
            defaultBgpIpAddresses: [
                '10.0.0.13'
            ]
            customBgpIpAddresses: []
            tunnelIpAddresses: [
                '20.84.34.225'
                '10.0.0.5'
            ]
        }
    ]
}
```

</details>
<p>

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

<details>

<summary>Parameter JSON format</summary>

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
tags: {
    Environment: 'Non-Prod'
    Contact: 'test.user@testcompany.com'
    PurchaseOrder: '1234'
    CostCenter: '7890'
    ServiceName: 'DeploymentValidation'
    Role: 'DeploymentValidation'
}
```

</details>
<p>

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the VPN gateway. |
| `resourceGroupName` | string | The name of the resource group the VPN gateway was deployed into. |
| `resourceId` | string | The resource ID of the VPN gateway. |

## Deployment examples

The following module usage examples are retrieved from the content of the files hosted in the module's `.test` folder.
   >**Note**: The name of each example is based on the name of the file from which it is taken.
   >**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

<h3>Example 1: Min</h3>

<details>

<summary>via Bicep module</summary>

```bicep
module vpnGateways './Microsoft.Network/vpnGateways/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-vpnGateways'
  params: {
    // Required parameters
    name: '<<namePrefix>>-az-vpngw-min-001'
    virtualHubResourceId: '/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-min-001'
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "<<namePrefix>>-az-vpngw-min-001"
    },
    "virtualHubResourceId": {
      "value": "/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-min-001"
    }
  }
}
```

</details>
<p>

<h3>Example 2: Parameters</h3>

<details>

<summary>via Bicep module</summary>

```bicep
module vpnGateways './Microsoft.Network/vpnGateways/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-vpnGateways'
  params: {
    // Required parameters
    name: '<<namePrefix>>-az-vpngw-x-001'
    virtualHubResourceId: '/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-x-001'
    // Non-required parameters
    bgpSettings: {
      asn: 65515
      peerWeight: 0
    }
    connections: [
      {
        connectionBandwidth: 10
        enableBgp: true
        name: 'Connection-<<namePrefix>>-az-vsite-x-001'
        remoteVpnSiteResourceId: '/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/vpnSites/<<namePrefix>>-az-vsite-x-001'
        routingConfiguration: {
          associatedRouteTable: {
            id: '/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-x-001/hubRouteTables/defaultRouteTable'
          }
          propagatedRouteTables: {
            ids: [
              {
                id: '/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-x-001/hubRouteTables/defaultRouteTable'
              }
            ]
            labels: [
              'default'
            ]
          }
          vnetRoutes: {
            staticRoutes: []
          }
        }
      }
    ]
    lock: 'CanNotDelete'
    natRules: [
      {
        externalMappings: [
          {
            addressSpace: '192.168.21.0/24'
          }
        ]
        internalMappings: [
          {
            addressSpace: '10.4.0.0/24'
          }
        ]
        mode: 'EgressSnat'
        name: 'natRule1'
        type: 'Static'
      }
    ]
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "<<namePrefix>>-az-vpngw-x-001"
    },
    "virtualHubResourceId": {
      "value": "/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-x-001"
    },
    // Non-required parameters
    "bgpSettings": {
      "value": {
        "asn": 65515,
        "peerWeight": 0
      }
    },
    "connections": {
      "value": [
        {
          "connectionBandwidth": 10,
          "enableBgp": true,
          "name": "Connection-<<namePrefix>>-az-vsite-x-001",
          "remoteVpnSiteResourceId": "/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/vpnSites/<<namePrefix>>-az-vsite-x-001",
          "routingConfiguration": {
            "associatedRouteTable": {
              "id": "/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-x-001/hubRouteTables/defaultRouteTable"
            },
            "propagatedRouteTables": {
              "ids": [
                {
                  "id": "/subscriptions/<<subscriptionId>>/resourceGroups/validation-rg/providers/Microsoft.Network/virtualHubs/<<namePrefix>>-az-vhub-x-001/hubRouteTables/defaultRouteTable"
                }
              ],
              "labels": [
                "default"
              ]
            },
            "vnetRoutes": {
              "staticRoutes": []
            }
          }
        }
      ]
    },
    "lock": {
      "value": "CanNotDelete"
    },
    "natRules": {
      "value": [
        {
          "externalMappings": [
            {
              "addressSpace": "192.168.21.0/24"
            }
          ],
          "internalMappings": [
            {
              "addressSpace": "10.4.0.0/24"
            }
          ],
          "mode": "EgressSnat",
          "name": "natRule1",
          "type": "Static"
        }
      ]
    }
  }
}
```

</details>
<p>
