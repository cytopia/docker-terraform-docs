# Test

Stuff before terraform-docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| computed_egress_rules | List of computed egress rules to create by name | `<list>` | no |
| computed_egress_with_cidr_blocks | List of computed egress rules to create where 'cidr_blocks' is used | `<list>` | no |
| computed_egress_with_ipv6_cidr_blocks | List of computed egress rules to create where 'ipv6_cidr_blocks' is used | `<list>` | no |
| computed_egress_with_self | List of computed egress rules to create where 'self' is defined | `<list>` | no |
| computed_egress_with_source_security_group_id | List of computed egress rules to create where 'source_security_group_id' is used | `<list>` | no |
| computed_ingress_rules | List of computed ingress rules to create by name | `<list>` | no |
| computed_ingress_with_cidr_blocks | List of computed ingress rules to create where 'cidr_blocks' is used | `<list>` | no |
| computed_ingress_with_ipv6_cidr_blocks | List of computed ingress rules to create where 'ipv6_cidr_blocks' is used | `<list>` | no |
| computed_ingress_with_self | List of computed ingress rules to create where 'self' is defined | `<list>` | no |
| computed_ingress_with_source_security_group_id | List of computed ingress rules to create where 'source_security_group_id' is used | `<list>` | no |
| create | Whether to create security group and all rules | `true` | no |
| database_outbound_acl_rules | Database subnets outbound network ACL rules | `<list>` | no |
| description | Description of security group | `Security Group managed by Terraform` | no |
| egress_cidr_blocks | List of IPv4 CIDR ranges to use on all egress rules | `<list>` | no |
| egress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all egress rules | `<list>` | no |
| egress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | `<list>` | no |
| egress_rules | List of egress rules to create by name | `<list>` | no |
| egress_with_cidr_blocks | List of egress rules to create where 'cidr_blocks' is used | `<list>` | no |
| egress_with_ipv6_cidr_blocks | List of egress rules to create where 'ipv6_cidr_blocks' is used | `<list>` | no |
| egress_with_self | List of egress rules to create where 'self' is defined | `<list>` | no |
| egress_with_source_security_group_id | List of egress rules to create where 'source_security_group_id' is used | `<list>` | no |
| ingress_cidr_blocks | List of IPv4 CIDR ranges to use on all ingress rules | `<list>` | no |
| ingress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all ingress rules | `<list>` | no |
| ingress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | `<list>` | no |
| ingress_rules | List of ingress rules to create by name | `<list>` | no |
| ingress_with_cidr_blocks | List of ingress rules to create where 'cidr_blocks' is used | `<list>` | no |
| ingress_with_ipv6_cidr_blocks | List of ingress rules to create where 'ipv6_cidr_blocks' is used | `<list>` | no |
| ingress_with_self | List of ingress rules to create where 'self' is defined | `<list>` | no |
| ingress_with_source_security_group_id | List of ingress rules to create where 'source_security_group_id' is used | `<list>` | no |
| name | Name of security group | - | yes |
| network | The network | `<map>` | no |
| number_of_computed_egress_rules | Number of computed egress rules to create by name | `0` | no |
| number_of_computed_egress_with_cidr_blocks | Number of computed egress rules to create where 'cidr_blocks' is used | `0` | no |
| number_of_computed_egress_with_ipv6_cidr_blocks | Number of computed egress rules to create where 'ipv6_cidr_blocks' is used | `0` | no |
| number_of_computed_egress_with_self | Number of computed egress rules to create where 'self' is defined | `0` | no |
| number_of_computed_egress_with_source_security_group_id | Number of computed egress rules to create where 'source_security_group_id' is used | `0` | no |
| number_of_computed_ingress_rules | Number of computed ingress rules to create by name | `0` | no |
| number_of_computed_ingress_with_cidr_blocks | Number of computed ingress rules to create where 'cidr_blocks' is used | `0` | no |
| number_of_computed_ingress_with_ipv6_cidr_blocks | Number of computed ingress rules to create where 'ipv6_cidr_blocks' is used | `0` | no |
| number_of_computed_ingress_with_self | Number of computed ingress rules to create where 'self' is defined | `0` | no |
| number_of_computed_ingress_with_source_security_group_id | Number of computed ingress rules to create where 'source_security_group_id' is used | `0` | no |
| tags | A mapping of tags to assign to security group | `<map>` | no |
| use_name_prefix | Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation | `true` | no |
| vpc_id | ID of the VPC where to create security group | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| environment |  |
| this_security_group_description |  |
| this_security_group_id |  |
| this_security_group_name |  |
| this_security_group_owner_id |  |
| this_security_group_vpc_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->	

Stuff after terraform-docs
