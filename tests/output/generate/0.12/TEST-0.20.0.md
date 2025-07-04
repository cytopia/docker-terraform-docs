## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `string` | n/a | yes |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone of the RDS instance | `string` | `""` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `1` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `string` | n/a | yes |
| <a name="input_character_set_name"></a> [character\_set\_name](#input\_character\_set\_name) | (Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information | `string` | `""` | no |
| <a name="input_computed_egress_rules"></a> [computed\_egress\_rules](#input\_computed\_egress\_rules) | List of computed egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_egress_with_cidr_blocks"></a> [computed\_egress\_with\_cidr\_blocks](#input\_computed\_egress\_with\_cidr\_blocks) | List of computed egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_ipv6_cidr_blocks"></a> [computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_computed\_egress\_with\_ipv6\_cidr\_blocks) | List of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_self"></a> [computed\_egress\_with\_self](#input\_computed\_egress\_with\_self) | List of computed egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_egress_with_source_security_group_id"></a> [computed\_egress\_with\_source\_security\_group\_id](#input\_computed\_egress\_with\_source\_security\_group\_id) | List of computed egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_rules"></a> [computed\_ingress\_rules](#input\_computed\_ingress\_rules) | List of computed ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_computed_ingress_with_cidr_blocks"></a> [computed\_ingress\_with\_cidr\_blocks](#input\_computed\_ingress\_with\_cidr\_blocks) | List of computed ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_ipv6_cidr_blocks"></a> [computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | List of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_self"></a> [computed\_ingress\_with\_self](#input\_computed\_ingress\_with\_self) | List of computed ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_computed_ingress_with_source_security_group_id"></a> [computed\_ingress\_with\_source\_security\_group\_id](#input\_computed\_ingress\_with\_source\_security\_group\_id) | List of computed ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create security group and all rules | `bool` | `true` | no |
| <a name="input_create_db_instance"></a> [create\_db\_instance](#input\_create\_db\_instance) | Whether to create a database instance | `bool` | `true` | no |
| <a name="input_create_db_option_group"></a> [create\_db\_option\_group](#input\_create\_db\_option\_group) | Whether to create a database option group | `bool` | `true` | no |
| <a name="input_create_db_parameter_group"></a> [create\_db\_parameter\_group](#input\_create\_db\_parameter\_group) | Whether to create a database parameter group | `bool` | `true` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | Whether to create a database subnet group | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `bool` | `false` | no |
| <a name="input_database_outbound_acl_rules"></a> [database\_outbound\_acl\_rules](#input\_database\_outbound\_acl\_rules) | Database subnets outbound network ACL rules | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of security group | `string` | `"Security Group managed by Terraform"` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_cidr_blocks"></a> [egress\_ipv6\_cidr\_blocks](#input\_egress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all egress rules | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_egress_prefix_list_ids"></a> [egress\_prefix\_list\_ids](#input\_egress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | `list(string)` | `[]` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_egress_with_cidr_blocks"></a> [egress\_with\_cidr\_blocks](#input\_egress\_with\_cidr\_blocks) | List of egress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_ipv6_cidr_blocks"></a> [egress\_with\_ipv6\_cidr\_blocks](#input\_egress\_with\_ipv6\_cidr\_blocks) | List of egress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_self"></a> [egress\_with\_self](#input\_egress\_with\_self) | List of egress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_egress_with_source_security_group_id"></a> [egress\_with\_source\_security\_group\_id](#input\_egress\_with\_source\_security\_group\_id) | List of egress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | The family of the DB parameter group | `string` | `""` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final DB snapshot when this DB instance is deleted. | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `false` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier | `string` | n/a | yes |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_ipv6_cidr_blocks"></a> [ingress\_ipv6\_cidr\_blocks](#input\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_prefix_list_ids"></a> [ingress\_prefix\_list\_ids](#input\_ingress\_prefix\_list\_ids) | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | `list(string)` | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_ingress_with_cidr_blocks"></a> [ingress\_with\_cidr\_blocks](#input\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_ipv6_cidr_blocks"></a> [ingress\_with\_ipv6\_cidr\_blocks](#input\_ingress\_with\_ipv6\_cidr\_blocks) | List of ingress rules to create where 'ipv6\_cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_self"></a> [ingress\_with\_self](#input\_ingress\_with\_self) | List of ingress rules to create where 'self' is defined | `list(map(string))` | `[]` | no |
| <a name="input_ingress_with_source_security_group_id"></a> [ingress\_with\_source\_security\_group\_id](#input\_ingress\_with\_source\_security\_group\_id) | List of ingress rules to create where 'source\_security\_group\_id' is used | `list(map(string))` | `[]` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | n/a | yes |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' | `number` | `0` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | `string` | `""` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `string` | n/a | yes |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with | `string` | `""` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `""` | no |
| <a name="input_monitoring_role_name"></a> [monitoring\_role\_name](#input\_monitoring\_role\_name) | Name of the IAM role which will be created when create\_monitoring\_role is enabled. | `string` | `"rds-monitoring-role"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of security group | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The network | <pre>object({<br>    vpc = object({<br>      id         = string<br>      cidr_block = string<br>    })<br>    subnets = set(object({<br>      id         = string<br>      cidr_block = string<br>    }))<br>  })</pre> | <pre>{<br>  "subnets": [<br>    {<br>      "cidr_block": "10.0.0.0/16",<br>      "id": "vpc-123456"<br>    }<br>  ],<br>  "vpc": {<br>    "cidr_block": "10.0.0.0/16",<br>    "id": "vpc-123456"<br>  }<br>}</pre> | no |
| <a name="input_number_of_computed_egress_rules"></a> [number\_of\_computed\_egress\_rules](#input\_number\_of\_computed\_egress\_rules) | Number of computed egress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_cidr\_blocks) | Number of computed egress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_egress\_with\_ipv6\_cidr\_blocks) | Number of computed egress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_self"></a> [number\_of\_computed\_egress\_with\_self](#input\_number\_of\_computed\_egress\_with\_self) | Number of computed egress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_egress_with_source_security_group_id"></a> [number\_of\_computed\_egress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_egress\_with\_source\_security\_group\_id) | Number of computed egress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_rules"></a> [number\_of\_computed\_ingress\_rules](#input\_number\_of\_computed\_ingress\_rules) | Number of computed ingress rules to create by name | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_cidr\_blocks) | Number of computed ingress rules to create where 'cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_ipv6_cidr_blocks"></a> [number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks](#input\_number\_of\_computed\_ingress\_with\_ipv6\_cidr\_blocks) | Number of computed ingress rules to create where 'ipv6\_cidr\_blocks' is used | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_self"></a> [number\_of\_computed\_ingress\_with\_self](#input\_number\_of\_computed\_ingress\_with\_self) | Number of computed ingress rules to create where 'self' is defined | `number` | `0` | no |
| <a name="input_number_of_computed_ingress_with_source_security_group_id"></a> [number\_of\_computed\_ingress\_with\_source\_security\_group\_id](#input\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id) | Number of computed ingress rules to create where 'source\_security\_group\_id' is used | `number` | `0` | no |
| <a name="input_option_group_description"></a> [option\_group\_description](#input\_option\_group\_description) | The description of the option group | `string` | `""` | no |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | Name of the DB option group to associate. Setting this automatically disables option\_group creation | `string` | `""` | no |
| <a name="input_options"></a> [options](#input\_options) | A list of Options to apply. | `any` | `[]` | no |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | n/a | `string` | `"%"` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | Description of the DB parameter group to create | `string` | `""` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to associate or create | `string` | `""` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DB parameters (map) to apply | `list(map(string))` | `[]` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `string` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Bool to control if instance is publicly accessible | `bool` | `false` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | `string` | `""` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `""` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. | `string` | `"gp2"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC subnet IDs | `list(string)` | `[]` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | This<br>is<br>a<br>test | `string` | `"This\nis\na\ntest\n"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_test_var"></a> [test\_var](#input\_test\_var) | This is a test variable | `string` | `""` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times | `map(string)` | <pre>{<br>  "create": "40m",<br>  "delete": "40m",<br>  "update": "80m"<br>}</pre> | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. | `string` | `""` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Whether to use name\_prefix or fixed name. Should be true to able to update security group name after initial creation | `bool` | `true` | no |
| <a name="input_use_parameter_group_name_prefix"></a> [use\_parameter\_group\_name\_prefix](#input\_use\_parameter\_group\_name\_prefix) | Whether to use the parameter group name prefix or not | `bool` | `true` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | The output |
| <a name="output_this_db_instance_address"></a> [this\_db\_instance\_address](#output\_this\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_this_db_instance_arn"></a> [this\_db\_instance\_arn](#output\_this\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_this_db_instance_availability_zone"></a> [this\_db\_instance\_availability\_zone](#output\_this\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_this_db_instance_endpoint"></a> [this\_db\_instance\_endpoint](#output\_this\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_this_db_instance_hosted_zone_id"></a> [this\_db\_instance\_hosted\_zone\_id](#output\_this\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_this_db_instance_id"></a> [this\_db\_instance\_id](#output\_this\_db\_instance\_id) | The RDS instance ID |
| <a name="output_this_db_instance_name"></a> [this\_db\_instance\_name](#output\_this\_db\_instance\_name) | The database name |
| <a name="output_this_db_instance_password"></a> [this\_db\_instance\_password](#output\_this\_db\_instance\_password) | The database password (this password may be old, because Terraform doesn't track it after initial creation) |
| <a name="output_this_db_instance_port"></a> [this\_db\_instance\_port](#output\_this\_db\_instance\_port) | The database port |
| <a name="output_this_db_instance_resource_id"></a> [this\_db\_instance\_resource\_id](#output\_this\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_this_db_instance_status"></a> [this\_db\_instance\_status](#output\_this\_db\_instance\_status) | The RDS instance status |
| <a name="output_this_db_instance_username"></a> [this\_db\_instance\_username](#output\_this\_db\_instance\_username) | The master username for the database |
| <a name="output_this_db_option_group_arn"></a> [this\_db\_option\_group\_arn](#output\_this\_db\_option\_group\_arn) | The ARN of the db option group |
| <a name="output_this_db_option_group_id"></a> [this\_db\_option\_group\_id](#output\_this\_db\_option\_group\_id) | The db option group id |
| <a name="output_this_db_parameter_group_arn"></a> [this\_db\_parameter\_group\_arn](#output\_this\_db\_parameter\_group\_arn) | The ARN of the db parameter group |
| <a name="output_this_db_parameter_group_id"></a> [this\_db\_parameter\_group\_id](#output\_this\_db\_parameter\_group\_id) | The db parameter group id |
| <a name="output_this_db_subnet_group_arn"></a> [this\_db\_subnet\_group\_arn](#output\_this\_db\_subnet\_group\_arn) | The ARN of the db subnet group |
| <a name="output_this_db_subnet_group_id"></a> [this\_db\_subnet\_group\_id](#output\_this\_db\_subnet\_group\_id) | The db subnet group name |
| <a name="output_this_security_group_description"></a> [this\_security\_group\_description](#output\_this\_security\_group\_description) | The description of the security group |
| <a name="output_this_security_group_id"></a> [this\_security\_group\_id](#output\_this\_security\_group\_id) | The ID of the security group |
| <a name="output_this_security_group_name"></a> [this\_security\_group\_name](#output\_this\_security\_group\_name) | The name of the security group |
| <a name="output_this_security_group_owner_id"></a> [this\_security\_group\_owner\_id](#output\_this\_security\_group\_owner\_id) | The owner ID |
| <a name="output_this_security_group_vpc_id"></a> [this\_security\_group\_vpc\_id](#output\_this\_security\_group\_vpc\_id) | The VPC ID |
