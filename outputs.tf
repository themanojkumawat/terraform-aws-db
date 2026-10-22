##-----------------------------------------------------------------------------
## RDS Primary Instance Outputs
##-----------------------------------------------------------------------------
output "db_instance_id" {
  value       = join("", aws_db_instance.this[*].id)
  description = "The RDS instance ID."
}

output "db_instance_arn" {
  value       = join("", aws_db_instance.this[*].arn)
  description = "The ARN of the RDS instance."
}

output "db_instance_endpoint" {
  value       = join("", aws_db_instance.this[*].endpoint)
  description = "The connection endpoint in address:port format."
}

output "db_instance_address" {
  value       = join("", aws_db_instance.this[*].address)
  description = "The hostname of the RDS instance."
}

output "db_instance_port" {
  value       = join("", aws_db_instance.this[*].port)
  description = "The database port."
}

output "db_instance_name" {
  value       = join("", aws_db_instance.this[*].db_name)
  description = "The database name."
}

output "db_instance_username" {
  value       = join("", aws_db_instance.this[*].username)
  description = "The master username for the database."
  sensitive   = true
}

output "db_instance_password" {
  value       = local.password
  description = "The master password for the database (auto-generated if not provided)."
  sensitive   = true
}

output "db_instance_status" {
  value       = join("", aws_db_instance.this[*].status)
  description = "The RDS instance status."
}

output "db_instance_availability_zone" {
  value       = join("", aws_db_instance.this[*].availability_zone)
  description = "The availability zone of the RDS instance."
}

output "db_instance_hosted_zone_id" {
  value       = join("", aws_db_instance.this[*].hosted_zone_id)
  description = "The canonical hosted zone ID of the DB instance."
}

##-----------------------------------------------------------------------------
## Read Replica Outputs
##-----------------------------------------------------------------------------
output "db_replica_id" {
  value       = join("", aws_db_instance.read[*].id)
  description = "The read replica RDS instance ID."
}

output "db_replica_endpoint" {
  value       = join("", aws_db_instance.read[*].endpoint)
  description = "The read replica connection endpoint."
}

##-----------------------------------------------------------------------------
## DB Subnet Group Outputs
##-----------------------------------------------------------------------------
output "db_subnet_group_id" {
  value       = join("", aws_db_subnet_group.this[*].id)
  description = "The DB subnet group ID."
}

output "db_subnet_group_arn" {
  value       = join("", aws_db_subnet_group.this[*].arn)
  description = "The ARN of the DB subnet group."
}

##-----------------------------------------------------------------------------
## DB Parameter Group Outputs
##-----------------------------------------------------------------------------
output "db_parameter_group_id" {
  value       = join("", aws_db_parameter_group.this[*].id)
  description = "The DB parameter group ID."
}

output "db_parameter_group_arn" {
  value       = join("", aws_db_parameter_group.this[*].arn)
  description = "The ARN of the DB parameter group."
}

##-----------------------------------------------------------------------------
## DB Option Group Outputs
##-----------------------------------------------------------------------------
output "db_option_group_id" {
  value       = join("", aws_db_option_group.this[*].id)
  description = "The DB option group ID."
}

output "db_option_group_arn" {
  value       = join("", aws_db_option_group.this[*].arn)
  description = "The ARN of the DB option group."
}

##-----------------------------------------------------------------------------
## Security Group Outputs
##-----------------------------------------------------------------------------
output "security_group_id" {
  value       = join("", aws_security_group.default[*].id)
  description = "The ID of the security group created for the RDS instance."
}

output "security_group_arn" {
  value       = join("", aws_security_group.default[*].arn)
  description = "The ARN of the security group created for the RDS instance."
}

##-----------------------------------------------------------------------------
## KMS Key Outputs
##-----------------------------------------------------------------------------
output "kms_key_id" {
  value       = join("", aws_kms_key.default[*].id)
  description = "The ID of the KMS key."
}

output "kms_key_arn" {
  value       = join("", aws_kms_key.default[*].arn)
  description = "The ARN of the KMS key."
}

##-----------------------------------------------------------------------------
## SSM Parameter Outputs
##-----------------------------------------------------------------------------
output "ssm_parameter_endpoint" {
  value       = join("", aws_ssm_parameter.secret_endpoint[*].name)
  description = "The name of the SSM parameter storing the DB endpoint."
}
