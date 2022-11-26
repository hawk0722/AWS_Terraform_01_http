# Terraform Sample
## Azure Resource
This includes of the following resources:
- Virtual private cloud
- Subnets (Public, Private)
- Route tables
- Internet gateways
- Security groups



## SystemConfiguration
![SystemConfiguration](/img/SystemConfiguration.svg)

## Route Table
Public Route Table

|  Destination  |  Target  |
| ---- | ---- |
|  10.0.0.0/16  |  local  |
|  0.0.0.0/0  |  Internet Gateway  |

Private Route Table

|  Destination  |  Target  |
| ---- | ---- |
|  10.0.0.0/16  |  local  |

## Security groups
Inbound rules
|  Type  |  Protocol  |  Port  range |  Source  |
| ---- | ---- | ---- | ---- |
|  HTTP  |  TCP  |  80  |  0.0.0.0/0  |

Outbound rules
|  Type  |  Protocol  |  Port  range |  Destination  |
| ---- | ---- | ---- | ---- |
|  All traffic  |  All  |  All  |  0.0.0.0/0  |

## Instructions
Make sure have the [AWS CLI](https://aws.amazon.com/jp/cli/) and [Terraform](https://www.terraform.io/downloads)

1. Update terraform.tfvars with your desired values.

2. Run the following command.

```bash:bash
terraform init
terraform plan
terraform apply
```

## Notes
- The deployment was tested on windows.
