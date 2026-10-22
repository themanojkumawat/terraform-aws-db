output "db_instance_id" {
  value       = module.oracle.db_instance_id
  description = "The RDS instance ID."
}

output "db_instance_arn" {
  value       = module.oracle.db_instance_arn
  description = "The ARN of the RDS instance."
}

output "db_instance_endpoint" {
  value       = module.oracle.db_instance_endpoint
  description = "The connection endpoint in address:port format."
}

output "db_instance_address" {
  value       = module.oracle.db_instance_address
  description = "The hostname of the RDS instance."
}

output "db_instance_port" {
  value       = module.oracle.db_instance_port
  description = "The database port."
}

output "db_instance_username" {
  value       = module.oracle.db_instance_username
  description = "The master username for the database."
  sensitive   = true
}

output "db_instance_password" {
  value       = module.oracle.db_instance_password
  description = "The master password for the database."
  sensitive   = true
}

output "db_subnet_group_id" {
  value       = module.oracle.db_subnet_group_id
  description = "The DB subnet group ID."
}

output "db_parameter_group_id" {
  value       = module.oracle.db_parameter_group_id
  description = "The DB parameter group ID."
}

output "security_group_id" {
  value       = module.oracle.security_group_id
  description = "The security group ID."
}

output "kms_key_arn" {
  value       = module.oracle.kms_key_arn
  description = "The ARN of the KMS key."
}
