## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allocated\_storage | The allocated storage in gigabytes | `string` | n/a | yes |
| backup\_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | n/a | yes |
| engine | The database engine to use | `string` | n/a | yes |
| engine\_version | The engine version to use | `string` | n/a | yes |
| final\_snapshot\_identifier | The name of your final DB snapshot when this DB instance is deleted. | `string` | n/a | yes |
| identifier | The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier | `string` | n/a | yes |
| instance\_class | The instance type of the RDS instance | `string` | n/a | yes |
| maintenance\_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | n/a | yes |
| name | Name of security group | `string` | n/a | yes |
| password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| port | The port on which the DB accepts connections | `string` | n/a | yes |
| username | Username for the master DB user | `string` | n/a | yes |
| vpc\_id | ID of the VPC where to create security group | `string` | n/a | yes |
| allow\_major\_version\_upgrade | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| apply\_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| auto\_minor\_version\_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| availability\_zone | The Availability Zone of the RDS instance | `string` | `""` | no |
| backup\_retention\_period | The days to retain backups for | `number` | `1` | no |
| character\_set\_name | (Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information | `string` | `""` | no |
| computed\_egress\_rules | List of computed egress rules to create by name | `list(string)` | `[]` | no |
| computed\_egress\_with\_cidr\_blocks | List of computed egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| computed\_egress\_with\_ipv6\_cidr\_blocks | List of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| computed\_egress\_with\_self | List of computed egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| computed\_egress\_with\_source\_security\_group\_id | List of computed egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| computed\_ingress\_rules | List of computed ingress rules to create by name | `list(string)` | `[]` | no |
| computed\_ingress\_with\_cidr\_blocks | List of computed ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| computed\_ingress\_with\_ipv6\_cidr\_blocks | List of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| computed\_ingress\_with\_self | List of computed ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| computed\_ingress\_with\_source\_security\_group\_id | List of computed ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| copy\_tags\_to\_snapshot | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `false` | no |
| create | Whether to create security group and all rules | `bool` | `true` | no |
| create\_db\_instance | Whether to create a database instance | `bool` | `true` | no |
| create\_db\_option\_group | Whether to create a database option group | `bool` | `true` | no |
| create\_db\_parameter\_group | Whether to create a database parameter group | `bool` | `true` | no |
| create\_db\_subnet\_group | Whether to create a database subnet group | `bool` | `true` | no |
| create\_monitoring\_role | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `bool` | `false` | no |
| database\_outbound\_acl\_rules | Database subnets outbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| db\_subnet\_group\_name | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| deletion\_protection | The database can't be deleted when this value is set to true. | `bool` | `false` | no |
| description | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| egress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| egress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| egress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | `list(string)` | `[]` | no |
| egress\_rules | List of egress rules to create by name | `list(string)` | `[]` | no |
| egress\_with\_cidr\_blocks | List of egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| egress\_with\_ipv6\_cidr\_blocks | List of egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| egress\_with\_self | List of egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| egress\_with\_source\_security\_group\_id | List of egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| enabled\_cloudwatch\_logs\_exports | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| family | The family of the DB parameter group | `string` | `""` | no |
| iam\_database\_authentication\_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `false` | no |
| ingress\_cidr\_blocks | List of IPv4 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| ingress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| ingress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | `list(string)` | `[]` | no |
| ingress\_rules | List of ingress rules to create by name | `list(string)` | `[]` | no |
| ingress\_with\_cidr\_blocks | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| ingress\_with\_ipv6\_cidr\_blocks | List of ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| ingress\_with\_self | List of ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| ingress\_with\_source\_security\_group\_id | List of ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| iops | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' | `number` | `0` | no |
| kms\_key\_id | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| license\_model | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | `string` | `""` | no |
| major\_engine\_version | Specifies the major version of the engine that this option group should be associated with | `string` | `""` | no |
| monitoring\_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| monitoring\_role\_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `""` | no |
| monitoring\_role\_name | Name of the IAM role which will be created when create\_monitoring\_role is enabled. | `string` | `"rds-monitoring-role"` | no |
| multi\_az | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| network | The network | <pre>object({<br>    vpc = object({<br>      id         = string<br>      cidr_block = string<br>    })<br>    subnets = set(object({<br>      id         = string<br>      cidr_block = string<br>    }))<br>  })</pre> | <pre>{<br>  "subnets": [<br>    {<br>      "cidr_block": "10.0.0.0/16",<br>      "id": "vpc-123456"<br>    }<br>  ],<br>  "vpc": {<br>    "cidr_block": "10.0.0.0/16",<br>    "id": "vpc-123456"<br>  }<br>}</pre> | no |
| number\_of\_computed\_egress\_rules | Number of computed egress rules to create by name | `number` | `0` | no |
| number\_of\_computed\_egress\_with\_cidr\_blocks | Number of computed egress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks | Number of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| number\_of\_computed\_egress\_with\_self | Number of computed egress rules to create where 'self' is defined | `number` | `0` | no |
| number\_of\_computed\_egress\_with\_source\_security\_group\_id | Number of computed egress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| number\_of\_computed\_ingress\_rules | Number of computed ingress rules to create by name | `number` | `0` | no |
| number\_of\_computed\_ingress\_with\_cidr\_blocks | Number of computed ingress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks | Number of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| number\_of\_computed\_ingress\_with\_self | Number of computed ingress rules to create where 'self' is defined | `number` | `0` | no |
| number\_of\_computed\_ingress\_with\_source\_security\_group\_id | Number of computed ingress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| option\_group\_description | The description of the option group | `string` | `""` | no |
| option\_group\_name | Name of the DB option group to associate. Setting this automatically disables option\_group creation | `string` | `""` | no |
| options | A list of Options to apply. | `any` | `[]` | no |
| override\_special | n/a | `string` | `"%"` | no |
| parameter\_group\_description | Description of the DB parameter group to create | `string` | `""` | no |
| parameter\_group\_name | Name of the DB parameter group to associate or create | `string` | `""` | no |
| parameters | A list of DB parameters (map) to apply | `list(map(string))` | `[]` | no |
| publicly\_accessible | Bool to control if instance is publicly accessible | `bool` | `false` | no |
| replicate\_source\_db | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | `string` | `""` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| snapshot\_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `""` | no |
| storage\_encrypted | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| storage\_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. | `string` | `"gp2"` | no |
| subnet\_ids | A list of VPC subnet IDs | `list(string)` | `[]` | no |
| subnetwork | This<br>is<br>a<br>test | `string` | `"This\nis\na\ntest\n"` | no |
| tags | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| test\_var | This is a test variable | `string` | `""` | no |
| timeouts | (Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times | `map(string)` | <pre>{<br>  "create": "40m",<br>  "delete": "40m",<br>  "update": "80m"<br>}</pre> | no |
| timezone | (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. | `string` | `""` | no |
| use\_name\_prefix | Whether to use name\_prefix or fixed name. Should be true to able to update security group name after initial creation | `bool` | `true` | no |
| use\_parameter\_group\_name\_prefix | Whether to use the parameter group name prefix or not | `bool` | `true` | no |
| vpc\_security\_group\_ids | List of VPC security groups to associate | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| environment | The output |
| this\_db\_instance\_address | The address of the RDS instance |
| this\_db\_instance\_arn | The ARN of the RDS instance |
| this\_db\_instance\_availability\_zone | The availability zone of the RDS instance |
| this\_db\_instance\_endpoint | The connection endpoint |
| this\_db\_instance\_hosted\_zone\_id | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| this\_db\_instance\_id | The RDS instance ID |
| this\_db\_instance\_name | The database name |
| this\_db\_instance\_password | The database password (this password may be old, because Terraform doesn't track it after initial creation) |
| this\_db\_instance\_port | The database port |
| this\_db\_instance\_resource\_id | The RDS Resource ID of this instance |
| this\_db\_instance\_status | The RDS instance status |
| this\_db\_instance\_username | The master username for the database |
| this\_db\_option\_group\_arn | The ARN of the db option group |
| this\_db\_option\_group\_id | The db option group id |
| this\_db\_parameter\_group\_arn | The ARN of the db parameter group |
| this\_db\_parameter\_group\_id | The db parameter group id |
| this\_db\_subnet\_group\_arn | The ARN of the db subnet group |
| this\_db\_subnet\_group\_id | The db subnet group name |
| this\_security\_group\_description | The description of the security group |
| this\_security\_group\_id | The ID of the security group |
| this\_security\_group\_name | The name of the security group |
| this\_security\_group\_owner\_id | The owner ID |
| this\_security\_group\_vpc\_id | The VPC ID |

