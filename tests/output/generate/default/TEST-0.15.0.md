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
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `any` | n/a | yes |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone of the RDS instance | `string` | `""` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance\_window | `any` | n/a | yes |
| <a name="input_character_set_name"></a> [character\_set\_name](#input\_character\_set\_name) | (Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information | `string` | `""` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | On delete, copy all Instance tags to the final snapshot (if final\_snapshot\_identifier is specified) | `bool` | `false` | no |
| <a name="input_create_db_instance"></a> [create\_db\_instance](#input\_create\_db\_instance) | Whether to create a database instance | `bool` | `true` | no |
| <a name="input_create_db_option_group"></a> [create\_db\_option\_group](#input\_create\_db\_option\_group) | Whether to create a database option group | `bool` | `true` | no |
| <a name="input_create_db_parameter_group"></a> [create\_db\_parameter\_group](#input\_create\_db\_parameter\_group) | Whether to create a database parameter group | `bool` | `true` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | Whether to create a database subnet group | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `bool` | `false` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `list` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use | `any` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `any` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | The family of the DB parameter group | `string` | `""` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final DB snapshot when this DB instance is deleted. | `bool` | `false` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `false` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier | `any` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `any` | n/a | yes |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS. Setting this implies a storage\_type of 'io1' | `number` | `0` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage\_encrypted is set to true and kms\_key\_id is not specified the default KMS key created in your account will be used | `string` | `""` | no |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | `string` | `""` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | `any` | n/a | yes |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with | `string` | `""` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring\_interval is non-zero. | `string` | `""` | no |
| <a name="input_monitoring_role_name"></a> [monitoring\_role\_name](#input\_monitoring\_role\_name) | Name of the IAM role which will be created when create\_monitoring\_role is enabled. | `string` | `"rds-monitoring-role"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the RDS instance is multi-AZ | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The DB schema name to create. If omitted, no database is created initially | `string` | `""` | no |
| <a name="input_option_group_description"></a> [option\_group\_description](#input\_option\_group\_description) | The description of the option group | `string` | `""` | no |
| <a name="input_option_group_name"></a> [option\_group\_name](#input\_option\_group\_name) | Name of the DB option group to associate. Setting this automatically disables option\_group creation | `string` | `""` | no |
| <a name="input_options"></a> [options](#input\_options) | A list of Options to apply. | `list` | `[]` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | Description of the DB parameter group to create | `string` | `""` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the DB parameter group to associate or create | `string` | `""` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of DB parameters (map) to apply | `list` | `[]` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `any` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `any` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Bool to control if instance is publicly accessible | `bool` | `false` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | `string` | `""` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `string` | `""` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `false` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. | `string` | `"gp2"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC subnet IDs | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times | `map` | <pre>{<br>  "create": "40m",<br>  "delete": "40m",<br>  "update": "80m"<br>}</pre> | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. | `string` | `""` | no |
| <a name="input_use_option_group_name_prefix"></a> [use\_option\_group\_name\_prefix](#input\_use\_option\_group\_name\_prefix) | Whether to use the option group name prefix or not | `bool` | `true` | no |
| <a name="input_use_parameter_group_name_prefix"></a> [use\_parameter\_group\_name\_prefix](#input\_use\_parameter\_group\_name\_prefix) | Whether to use the parameter group name prefix or not | `bool` | `true` | no |
| <a name="input_use_subnet_group_name_prefix"></a> [use\_subnet\_group\_name\_prefix](#input\_use\_subnet\_group\_name\_prefix) | Whether to use the subnet group name prefix or not | `bool` | `true` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `any` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
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
| <a name="output_this_db_subnet_group_id"></a> [this\_db\_subnet\_group\_id](#output\_this\_db\_subnet\_group\_id) | The db subnet group id |
