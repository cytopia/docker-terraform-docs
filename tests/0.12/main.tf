variable "database_outbound_acl_rules" {
  description = "Database subnets outbound network ACL rules"
  type        = list(map(string))
  default     = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "network" {
  description = "The network"
  type        = object({
    vpc = object({
      id         = string
      cidr_block = string
    })
    subnets = set(object({
      id         = string
      cidr_block = string
    }))
  })
  default     = {
    vpc = {
      id          = "vpc-123456"
      cidr_block  = "10.0.0.0/16"
    },
    subnets = [
      {
        id          = "vpc-123456"
        cidr_block  = "10.0.0.0/16"
      },
    ],
  }
}

output "environment" {
  description = "The output"
  value       = {
    id = aws_elastic_beanstalk_environment.example.id
    vpc_settings = {
      for s in aws_elastic_beanstalk_environment.example.all_settings :
      s.name => s.value
      if s.namespace == "aws:ec2:vpc"
    }
  }
}


###################################################################################################
#
# Quoted type (https://github.com/antonbabenko/pre-commit-terraform/issues/52)
#
###################################################################################################
variable "test_var" {
  type        = "string"
  description = "This is a test variable"
  default     = ""
}


###################################################################################################
#
# https://github.com/terraform-aws-modules/terraform-aws-rds: variables.tf
#
###################################################################################################
variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = ""
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  type        = string
  default     = ""
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  type        = string
  default     = ""
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  type        = string
  default     = ""
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = false
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  type        = string
  default     = null
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = ""
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = ""
}

variable "parameter_group_description" {
  description = "Description of the DB parameter group to create"
  type        = string
  default     = ""
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = ""
}

variable "option_group_name" {
  description = "Name of the DB option group to associate. Setting this automatically disables option_group creation"
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  type        = number
  default     = 0
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  type        = string
  default     = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

# DB subnet group
variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

# DB parameter group
variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = ""
}

variable "parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}

# DB option group
variable "option_group_description" {
  description = "The description of the option group"
  type        = string
  default     = ""
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = ""
}

variable "options" {
  description = "A list of Options to apply."
  type        = any
  default     = []
}

variable "create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = true
}

variable "create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "create_db_option_group" {
  description = "Whether to create a database option group"
  type        = bool
  default     = true
}

variable "create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}

variable "timezone" {
  description = "(Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
  type        = string
  default     = ""
}

variable "character_set_name" {
  description = "(Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information"
  type        = string
  default     = ""
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "(Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default = {
    create = "40m"
    update = "80m"
    delete = "40m"
  }
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}

variable "use_parameter_group_name_prefix" {
  description = "Whether to use the parameter group name prefix or not"
  type        = bool
  default     = true
}


###################################################################################################
#
# https://github.com/terraform-aws-modules/terraform-aws-rds: outputs.tf
#
###################################################################################################

output "this_db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.db_instance.this_db_instance_address
}

output "this_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.db_instance.this_db_instance_arn
}

output "this_db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.db_instance.this_db_instance_availability_zone
}

output "this_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.db_instance.this_db_instance_endpoint
}

output "this_db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = module.db_instance.this_db_instance_hosted_zone_id
}

output "this_db_instance_id" {
  description = "The RDS instance ID"
  value       = module.db_instance.this_db_instance_id
}

output "this_db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.db_instance.this_db_instance_resource_id
}

output "this_db_instance_status" {
  description = "The RDS instance status"
  value       = module.db_instance.this_db_instance_status
}

output "this_db_instance_name" {
  description = "The database name"
  value       = module.db_instance.this_db_instance_name
}

output "this_db_instance_username" {
  description = "The master username for the database"
  value       = module.db_instance.this_db_instance_username
}

output "this_db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = var.password
}

output "this_db_instance_port" {
  description = "The database port"
  value       = module.db_instance.this_db_instance_port
}

output "this_db_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.db_subnet_group.this_db_subnet_group_id
}

output "this_db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = module.db_subnet_group.this_db_subnet_group_arn
}

output "this_db_parameter_group_id" {
  description = "The db parameter group id"
  value       = module.db_parameter_group.this_db_parameter_group_id
}

output "this_db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = module.db_parameter_group.this_db_parameter_group_arn
}

# DB option group
output "this_db_option_group_id" {
  description = "The db option group id"
  value       = module.db_option_group.this_db_option_group_id
}

output "this_db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = module.db_option_group.this_db_option_group_arn
}

###################################################################################################
#
# https://github.com/terraform-aws-modules/terraform-aws-security-group: variables.tf
#
###################################################################################################

#################
# Security group
#################
variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}

variable "name" {
  description = "Name of security group"
  type        = string
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_with_self" {
  description = "List of ingress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_ipv6_cidr_blocks" {
  description = "List of ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules"
  type        = list(string)
  default     = []
}

###################
# Computed Ingress
###################
variable "computed_ingress_rules" {
  description = "List of computed ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "computed_ingress_with_self" {
  description = "List of computed ingress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "computed_ingress_with_cidr_blocks" {
  description = "List of computed ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_ingress_with_ipv6_cidr_blocks" {
  description = "List of computed ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_ingress_with_source_security_group_id" {
  description = "List of computed ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

###################################
# Number of computed ingress rules
###################################
variable "number_of_computed_ingress_rules" {
  description = "Number of computed ingress rules to create by name"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_self" {
  description = "Number of computed ingress rules to create where 'self' is defined"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_cidr_blocks" {
  description = "Number of computed ingress rules to create where 'cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_ipv6_cidr_blocks" {
  description = "Number of computed ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_ingress_with_source_security_group_id" {
  description = "Number of computed ingress rules to create where 'source_security_group_id' is used"
  type        = number
  default     = 0
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_self" {
  description = "List of egress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_ipv6_cidr_blocks" {
  description = "List of egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["::/0"]
}

variable "egress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules"
  type        = list(string)
  default     = []
}

##################
# Computed Egress
##################
variable "computed_egress_rules" {
  description = "List of computed egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "computed_egress_with_self" {
  description = "List of computed egress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_cidr_blocks" {
  description = "List of computed egress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_ipv6_cidr_blocks" {
  description = "List of computed egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "computed_egress_with_source_security_group_id" {
  description = "List of computed egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

##################################
# Number of computed egress rules
##################################
variable "number_of_computed_egress_rules" {
  description = "Number of computed egress rules to create by name"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_self" {
  description = "Number of computed egress rules to create where 'self' is defined"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_cidr_blocks" {
  description = "Number of computed egress rules to create where 'cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_ipv6_cidr_blocks" {
  description = "Number of computed egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = number
  default     = 0
}

variable "number_of_computed_egress_with_source_security_group_id" {
  description = "Number of computed egress rules to create where 'source_security_group_id' is used"
  type        = number
  default     = 0
}


###################################################################################################
#
# https://github.com/terraform-aws-modules/terraform-aws-security-group: outputs.tf
#
###################################################################################################


output "this_security_group_id" {
  description = "The ID of the security group"
  value = concat(
    aws_security_group.this.*.id,
    aws_security_group.this_name_prefix.*.id,
    [""],
  )[0]
}

output "this_security_group_vpc_id" {
  description = "The VPC ID"
  value = concat(
    aws_security_group.this.*.vpc_id,
    aws_security_group.this_name_prefix.*.vpc_id,
    [""],
  )[0]
}

output "this_security_group_owner_id" {
  description = "The owner ID"
  value = concat(
    aws_security_group.this.*.owner_id,
    aws_security_group.this_name_prefix.*.owner_id,
    [""],
  )[0]
}

output "this_security_group_name" {
  description = "The name of the security group"
  value = concat(
    aws_security_group.this.*.name,
    aws_security_group.this_name_prefix.*.name,
    [""],
  )[0]
}

output "this_security_group_description" {
  description = "The description of the security group"
  value = concat(
    aws_security_group.this.*.description,
    aws_security_group.this_name_prefix.*.description,
    [""],
  )[0]
}

//output "this_security_group_ingress" {
//  description = "The ingress rules"
//  value       = "${element(concat(aws_security_group.this.*.ingress, list("")), 0)}"
//}
//output "this_security_group_egress" {
//  description = "The egress rules"
//    value       = "${element(concat(aws_security_group.this.*.egress, list("")), 0)"
//}
