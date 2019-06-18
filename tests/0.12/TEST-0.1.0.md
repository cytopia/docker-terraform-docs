# Test

Stuff before terraform-docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| allocated_storage | The allocated storage in gigabytes | - | yes |
| allow_major_version_upgrade | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `false` | no |
| apply_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `false` | no |
| auto_minor_version_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | `true` | no |
| availability_zone | The Availability Zone of the RDS instance | `` | no |
| backup_retention_period | The days to retain backups for | `1` | no |
| backup_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window | - | yes |
| character_set_name | (Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information | `` | no |
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
| copy_tags_to_snapshot | On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified) | `false` | no |
| create | Whether to create security group and all rules | `true` | no |
| create_db_instance | Whether to create a database instance | `true` | no |
| create_db_option_group | Whether to create a database option group | `true` | no |
| create_db_parameter_group | Whether to create a database parameter group | `true` | no |
| create_db_subnet_group | Whether to create a database subnet group | `true` | no |
| create_monitoring_role | Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `false` | no |
| database_outbound_acl_rules | Database subnets outbound network ACL rules | `<list>` | no |
| db_subnet_group_name | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `` | no |
| deletion_protection | The database can't be deleted when this value is set to true. | `false` | no |
| description | Description of security group | `Security Group managed by Terraform` | no |
| egress_cidr_blocks | List of IPv4 CIDR ranges to use on all egress rules | `<list>` | no |
| egress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all egress rules | `<list>` | no |
| egress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules | `<list>` | no |
| egress_rules | List of egress rules to create by name | `<list>` | no |
| egress_with_cidr_blocks | List of egress rules to create where 'cidr_blocks' is used | `<list>` | no |
| egress_with_ipv6_cidr_blocks | List of egress rules to create where 'ipv6_cidr_blocks' is used | `<list>` | no |
| egress_with_self | List of egress rules to create where 'self' is defined | `<list>` | no |
| egress_with_source_security_group_id | List of egress rules to create where 'source_security_group_id' is used | `<list>` | no |
| enabled_cloudwatch_logs_exports | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). | `<list>` | no |
| engine | The database engine to use | - | yes |
| engine_version | The engine version to use | - | yes |
| family | The family of the DB parameter group | `` | no |
| final_snapshot_identifier | The name of your final DB snapshot when this DB instance is deleted. | `null` | no |
| iam_database_authentication_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `false` | no |
| identifier | The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier | - | yes |
| ingress_cidr_blocks | List of IPv4 CIDR ranges to use on all ingress rules | `<list>` | no |
| ingress_ipv6_cidr_blocks | List of IPv6 CIDR ranges to use on all ingress rules | `<list>` | no |
| ingress_prefix_list_ids | List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules | `<list>` | no |
| ingress_rules | List of ingress rules to create by name | `<list>` | no |
| ingress_with_cidr_blocks | List of ingress rules to create where 'cidr_blocks' is used | `<list>` | no |
| ingress_with_ipv6_cidr_blocks | List of ingress rules to create where 'ipv6_cidr_blocks' is used | `<list>` | no |
| ingress_with_self | List of ingress rules to create where 'self' is defined | `<list>` | no |
| ingress_with_source_security_group_id | List of ingress rules to create where 'source_security_group_id' is used | `<list>` | no |
| instance_class | The instance type of the RDS instance | - | yes |
| iops | The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' | `0` | no |
| kms_key_id | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | `` | no |
| license_model | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | `` | no |
| maintenance_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | - | yes |
| major_engine_version | Specifies the major version of the engine that this option group should be associated with | `` | no |
| monitoring_interval | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. | `0` | no |
| monitoring_role_arn | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero. | `` | no |
| monitoring_role_name | Name of the IAM role which will be created when create_monitoring_role is enabled. | `rds-monitoring-role` | no |
| multi_az | Specifies if the RDS instance is multi-AZ | `false` | no |
| name | Name of security group | - | yes |
| name | The DB name to create. If omitted, no database is created initially | `` | no |
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
| option_group_description | The description of the option group | `` | no |
| option_group_name | Name of the DB option group to associate. Setting this automatically disables option_group creation | `` | no |
| options | A list of Options to apply. | `<list>` | no |
| parameter_group_description | Description of the DB parameter group to create | `` | no |
| parameter_group_name | Name of the DB parameter group to associate or create | `` | no |
| parameters | A list of DB parameters (map) to apply | `<list>` | no |
| password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | - | yes |
| port | The port on which the DB accepts connections | - | yes |
| publicly_accessible | Bool to control if instance is publicly accessible | `false` | no |
| replicate_source_db | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | `` | no |
| skip_final_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier | `true` | no |
| snapshot_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | `` | no |
| storage_encrypted | Specifies whether the DB instance is encrypted | `false` | no |
| storage_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. | `gp2` | no |
| subnet_ids | A list of VPC subnet IDs | `<list>` | no |
| tags | A mapping of tags to assign to security group | `<map>` | no |
| tags | A mapping of tags to assign to all resources | `<map>` | no |
| timeouts | (Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times | `<map>` | no |
| timezone | (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. | `` | no |
| use_name_prefix | Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation | `true` | no |
| use_parameter_group_name_prefix | Whether to use the parameter group name prefix or not | `true` | no |
| username | Username for the master DB user | - | yes |
| vpc_id | ID of the VPC where to create security group | - | yes |
| vpc_security_group_ids | List of VPC security groups to associate | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| environment |  |
| this_db_instance_address |  |
| this_db_instance_arn |  |
| this_db_instance_availability_zone |  |
| this_db_instance_endpoint |  |
| this_db_instance_hosted_zone_id |  |
| this_db_instance_id |  |
| this_db_instance_name |  |
| this_db_instance_password |  |
| this_db_instance_port |  |
| this_db_instance_resource_id |  |
| this_db_instance_status |  |
| this_db_instance_username |  |
| this_db_option_group_arn |  |
| this_db_option_group_id |  |
| this_db_parameter_group_arn |  |
| this_db_parameter_group_id |  |
| this_db_subnet_group_arn |  |
| this_db_subnet_group_id |  |
| this_security_group_description |  |
| this_security_group_id |  |
| this_security_group_name |  |
| this_security_group_owner_id |  |
| this_security_group_vpc_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->	

Stuff after terraform-docs
