output "db_instance_id" {
  value       = module.mysql.db_instance_id
  description = "The primary RDS instance ID."
}

output "db_instance_arn" {
  value       = module.mysql.db_instance_arn
  description = "The ARN of the primary RDS instance."
}

output "db_instance_endpoint" {
  value       = module.mysql.db_instance_endpoint
  description = "The primary connection endpoint in address:port format."
}

output "db_instance_address" {
  value       = module.mysql.db_instance_address
  description = "The hostname of the primary RDS instance."
}

output "db_instance_port" {
  value       = module.mysql.db_instance_port
  description = "The database port."
}

output "db_instance_username" {
  value       = module.mysql.db_instance_username
  description = "The master username for the database."
  sensitive   = true
}

output "db_instance_password" {
  value       = module.mysql.db_instance_password
  description = "The master password for the database."
  sensitive   = true
}

output "db_replica_id" {
  value       = module.mysql.db_replica_id
  description = "The read replica RDS instance ID."
}

output "db_replica_endpoint" {
  value       = module.mysql.db_replica_endpoint
  description = "The read replica connection endpoint."
}

output "db_subnet_group_id" {
  value       = module.mysql.db_subnet_group_id
  description = "The DB subnet group ID."
}

output "db_parameter_group_id" {
  value       = module.mysql.db_parameter_group_id
  description = "The DB parameter group ID."
}

output "security_group_id" {
  value       = module.mysql.security_group_id
  description = "The security group ID."
}

output "kms_key_arn" {
  value       = module.mysql.kms_key_arn
  description = "The ARN of the KMS key."
}

output "ssm_parameter_endpoint" {
  value       = module.mysql.ssm_parameter_endpoint
  description = "The SSM parameter name storing the DB endpoint."
}
