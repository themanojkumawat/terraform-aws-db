##-----------------------------------------------------------------------------
## Labels / Meta
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = ""
  description = "Name (e.g. `app` or `mysql`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/themanojkumawat/terraform-aws-db"
  description = "Terraform current module repo."
}

variable "managedby" {
  type        = string
  default     = "themanojkumawat"
  description = "ManagedBy, e.g. 'themanojkumawat'."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between environment and name."
}

##-----------------------------------------------------------------------------
## Common
##-----------------------------------------------------------------------------
variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create this resource or not?"
}

##-----------------------------------------------------------------------------
## RDS Instance
##-----------------------------------------------------------------------------
variable "identifier" {
  type        = string
  default     = ""
  description = "The name of the RDS instance."
}

variable "use_identifier_prefix" {
  type        = bool
  default     = false
  description = "Determines whether to use identifier as is or create a unique identifier beginning with identifier as the specified prefix."
}

variable "custom_iam_instance_profile" {
  type        = string
  default     = null
  description = "RDS custom IAM instance profile."
}

variable "allocated_storage" {
  type        = string
  default     = null
  description = "The allocated storage in gigabytes."
}

variable "max_allocated_storage" {
  type        = number
  default     = 0
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage."
}

variable "storage_type" {
  type        = string
  default     = null
  description = "One of 'standard', 'gp2', 'gp3', or 'io1'."
}

variable "storage_throughput" {
  type        = number
  default     = null
  description = "Storage throughput value for the DB instance. Applies only to gp3 storage type."
}

variable "storage_encrypted" {
  type        = bool
  default     = true
  description = "Specifies whether the DB instance is encrypted."
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS encryption key. If storage_encrypted is set to true and kms_key_id is not specified, the default KMS key created in your account will be used."
}

variable "replicate_source_db" {
  type        = string
  default     = null
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database."
}

variable "license_model" {
  type        = string
  default     = null
  description = "License model information for this DB instance. Optional, but required for some DB engines, e.g. Oracle SE1."
}

variable "replica_mode" {
  type        = string
  default     = null
  description = "Specifies whether the replica is in either mounted or open-read-only mode. Only supported by Oracle instances."
}

variable "iam_database_authentication_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether IAM accounts to database accounts mapping is enabled."
}

variable "domain" {
  type        = string
  default     = null
  description = "The ID of the Directory Service Active Directory domain to create the instance in."
}

variable "domain_iam_role_name" {
  type        = string
  default     = null
  description = "The name of the IAM role to be used when making API calls to the Directory Service."
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "The database engine to use."
}

variable "engine_name" {
  type        = string
  default     = "mysql"
  description = "Specifies the name of the engine that this option group should be associated with."
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "The engine version to use."
}

variable "instance_class" {
  type        = string
  default     = null
  description = "The instance type of the RDS instance."
}

variable "db_name" {
  type        = string
  default     = null
  description = "The DB name to create. If omitted, no database is created initially."
}

variable "username" {
  type        = string
  default     = null
  description = "Username for the master DB user."
}

variable "password" {
  type        = string
  default     = null
  description = "Password for the master DB user. If empty, a random password is generated."
  sensitive   = true
}

variable "port" {
  type        = string
  default     = null
  description = "The port on which the DB accepts connections."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this database from a snapshot."
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = true
  description = "On delete, copy all Instance tags to the final snapshot."
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
  description = "Name of DB subnet group. If unspecified, will be created in the default VPC."
}

variable "availability_zone" {
  type        = string
  default     = null
  description = "The Availability Zone of the RDS instance."
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Specifies if the RDS instance is multi-AZ."
}

variable "iops" {
  type        = number
  default     = null
  description = "The amount of provisioned IOPS."
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Bool to control if instance is publicly accessible."
}

variable "monitoring_interval" {
  type        = number
  default     = 0
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected. Valid Values: 0, 1, 5, 10, 15, 30, 60."
}

variable "allow_major_version_upgrade" {
  type        = bool
  default     = false
  description = "Indicates that major version upgrades are allowed."
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = true
  description = "Indicates that minor engine upgrades will be applied automatically during the maintenance window."
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
}

variable "maintenance_window" {
  type        = string
  default     = null
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'."
}

variable "blue_green_update" {
  type        = map(string)
  default     = {}
  description = "Enables low-downtime updates using RDS Blue/Green deployments."
}

variable "backup_retention_period" {
  type        = number
  default     = null
  description = "The days to retain backups for."
}

variable "backup_window" {
  type        = string
  default     = null
  description = "The daily time range (in UTC) during which automated backups are created."
}

variable "timezone" {
  type        = string
  default     = null
  description = "Time zone of the DB instance. Only supported by Microsoft SQL Server."
}

variable "character_set_name" {
  type        = string
  default     = null
  description = "The character set name to use for DB encoding in Oracle instances."
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = []
  description = "List of log types to enable for exporting to CloudWatch logs."
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "The database can't be deleted when this value is set to true."
}

variable "delete_automated_backups" {
  type        = bool
  default     = true
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted."
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether Performance Insights are enabled."
}

variable "performance_insights_retention_period" {
  type        = number
  default     = 7
  description = "The amount of time in days to retain Performance Insights data."
}

variable "performance_insights_kms_key_id" {
  type        = string
  default     = null
  description = "The ARN for the KMS key to encrypt Performance Insights data."
}

variable "ca_cert_identifier" {
  type        = string
  default     = null
  description = "Specifies the identifier of the CA certificate for the DB instance."
}

variable "network_type" {
  type        = string
  default     = null
  description = "The type of network stack (IPV4 or DUAL)."
}

variable "s3_import" {
  type        = map(string)
  default     = null
  description = "Restore from a Percona Xtrabackup in S3 (only MySQL is supported)."
}

variable "restore_to_point_in_time" {
  type        = map(string)
  default     = null
  description = "Restore to a point in time (MySQL is NOT supported)."
}

variable "timeouts" {
  type        = map(string)
  default     = {}
  description = "Define maximum timeout for create, update, delete operations."
}

##-----------------------------------------------------------------------------
## Read Replica
##-----------------------------------------------------------------------------
variable "enabled_read_replica" {
  type        = bool
  default     = true
  description = "Whether to create the primary RDS instance."
}

variable "enabled_replica" {
  type        = bool
  default     = false
  description = "Whether to create a read replica."
}

variable "replica_instance_class" {
  type        = string
  default     = ""
  description = "The instance type of the read replica."
}

##-----------------------------------------------------------------------------
## DB Subnet Group
##-----------------------------------------------------------------------------
variable "enabled_db_subnet_group" {
  type        = bool
  default     = true
  description = "Whether to create a DB subnet group."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of VPC Subnet IDs to launch in."
}

##-----------------------------------------------------------------------------
## DB Parameter Group
##-----------------------------------------------------------------------------
variable "family" {
  type        = string
  default     = null
  description = "The family of the DB parameter group (e.g. mysql8.0, postgres14)."
}

variable "parameters" {
  type        = list(map(string))
  default     = []
  description = "A list of DB parameter maps to apply."
}

##-----------------------------------------------------------------------------
## DB Option Group
##-----------------------------------------------------------------------------
variable "major_engine_version" {
  type        = string
  default     = ""
  description = "Specifies the major version of the engine that this option group should be associated with."
}

variable "option_group_description" {
  type        = string
  default     = null
  description = "The description of the option group."
}

variable "options" {
  type        = any
  default     = []
  description = "A list of Options to apply."
}

##-----------------------------------------------------------------------------
## Security Group
##-----------------------------------------------------------------------------
variable "enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "sg_ids" {
  type        = list(any)
  default     = []
  description = "List of existing security group IDs to use."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "sg_description" {
  type        = string
  default     = "Instance default security group (only egress access is allowed)."
  description = "The security group description."
}

variable "is_external" {
  type        = bool
  default     = false
  description = "Enable to use existing security group."
}

variable "egress_rule" {
  type        = bool
  default     = true
  description = "Enable to create egress rule."
}

variable "sg_egress_description" {
  type        = string
  default     = "Description of the egress rule."
  description = "Description of the egress rule."
}

variable "sg_egress_ipv6_description" {
  type        = string
  default     = "Description of the egress IPv6 rule."
  description = "Description of the IPv6 egress rule."
}

variable "allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed IP CIDRs."
}

variable "allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports."
}

variable "sg_ingress_description" {
  type        = string
  default     = "Description of the ingress rule use RDS."
  description = "Description of the ingress rule."
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol for security group rules."
}

##-----------------------------------------------------------------------------
## KMS
##-----------------------------------------------------------------------------
variable "kms_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the KMS key is enabled or disabled."
}

variable "kms_description" {
  type        = string
  default     = "RDS KMS master key"
  description = "The description of the key as viewed in AWS console."
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  sensitive   = true
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT."
}

variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "Duration in days after which the key is deleted after destruction of the resource."
}

variable "is_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the key is enabled."
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled."
}

variable "rotation_period_in_days" {
  type        = number
  default     = 365
  description = "Custom period for key rotation in days (90-2560)."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  sensitive   = true
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair."
}

variable "bypass_policy_lockout_safety_check" {
  type        = bool
  default     = false
  description = "Whether to bypass the key policy lockout safety check."
}

variable "custom_key_store_id" {
  type        = string
  default     = null
  description = "Custom Key Store ID where the key will be stored."
}

variable "kms_multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region key."
}

variable "alias" {
  type        = string
  default     = "alias/rds"
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash."
}

##-----------------------------------------------------------------------------
## CloudWatch
##-----------------------------------------------------------------------------
variable "enabled_cloudwatch_log_group" {
  type        = bool
  default     = false
  description = "Determines whether a CloudWatch log group is created for each enabled_cloudwatch_logs_exports."
}

variable "cloudwatch_log_group_retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to retain CloudWatch logs for the DB instance."
}

variable "skip_destroy" {
  type        = bool
  default     = false
  description = "Set to true to prevent log group deletion during destroy."
}

variable "log_group_class" {
  type        = string
  default     = "STANDARD"
  description = "Specifies the log class of the log group. Possible values: STANDARD or INFREQUENT_ACCESS."
}

##-----------------------------------------------------------------------------
## IAM / Enhanced Monitoring
##-----------------------------------------------------------------------------
variable "enabled_monitoring_role" {
  type        = bool
  default     = false
  description = "Create IAM role for enhanced monitoring."
}

variable "monitoring_role_description" {
  type        = string
  default     = null
  description = "Description of the monitoring IAM role."
}

variable "monitoring_role_permissions_boundary" {
  type        = string
  default     = null
  description = "ARN of the policy that is used to set the permissions boundary for the monitoring IAM role."
}

variable "monitoring_role_path" {
  type        = string
  default     = "/"
  description = "Path for the IAM role."
}

variable "monitoring_role_max_session_duration" {
  type        = number
  default     = 3600
  description = "Maximum session duration for the role in seconds."
}

variable "force_detach_policies" {
  type        = bool
  default     = false
  description = "Force detaching any policies the role has before destroying it."
}

variable "inline_policies" {
  type        = map(string)
  default     = {}
  description = "Map of inline policies to attach to the IAM role."
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM managed policy ARNs to attach to the IAM role."
}

##-----------------------------------------------------------------------------
## SSM Parameter
##-----------------------------------------------------------------------------
variable "ssm_parameter_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Whether to store the DB endpoint in SSM Parameter Store."
}

variable "ssm_parameter_description" {
  type        = string
  default     = "DB endpoint stored in SSM Parameter Store."
  description = "Description of the SSM parameter."
}

variable "ssm_parameter_type" {
  type        = string
  default     = "SecureString"
  description = "Type of the SSM parameter."
}

variable "ssm_parameter_allowed_pattern" {
  type        = string
  default     = ""
  description = "Allowed pattern to validate the parameter value."
}

variable "ssm_parameter_data_type" {
  type        = string
  default     = "text"
  description = "The data type of the SSM parameter."
}

variable "ssm_parameter_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the SSM parameter."
}

variable "ssm_parameter_tier" {
  type        = string
  default     = "Standard"
  description = "The tier of the SSM parameter (Standard, Advanced, Intelligent-Tiering)."
}

##-----------------------------------------------------------------------------
## Extra Tags per resource
##-----------------------------------------------------------------------------
variable "db_subnet_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB subnet group."
}

variable "db_parameter_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB parameter group."
}

variable "db_option_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the DB option group."
}

variable "cloudwatch_log_group_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the CloudWatch log group."
}

variable "db_instance_this_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the primary DB instance."
}

variable "db_instance_read_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the read replica DB instance."
}

variable "mysql_iam_role_tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags for the IAM monitoring role."
}
