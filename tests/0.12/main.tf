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
