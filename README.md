# terraform-aws-db

Terraform module to provision an AWS RDS (Relational Database Service) instance with all associated resources — Subnet Group, Parameter Group, Option Group, Security Group, KMS encryption, Enhanced Monitoring, CloudWatch Logs, SSM Parameter Store integration, and Read Replica support.

> Maintained by [themanojkumawat](https://github.com/themanojkumawat)

## Features

- RDS DB instance (MySQL, PostgreSQL, MariaDB, Oracle, SQL Server)
- DB Subnet Group
- DB Parameter Group
- DB Option Group
- Security Group with configurable ingress rules
- KMS key for encryption (auto-created or BYO)
- Enhanced Monitoring via IAM role
- CloudWatch Log Groups per log export type
- SSM Parameter Store for DB endpoint
- Read Replica support
- Auto-generated random password if not provided

## Usage

```hcl
module "mysql" {
  source      = "git::https://github.com/themanojkumawat/terraform-aws-db.git?ref=master"
  name        = "mysql"
  environment = "dev"
  managedby   = "themanojkumawat"

  engine               = "mysql"
  engine_name          = "mysql"
  engine_version       = "8.0.35"
  major_engine_version = "8.0"
  instance_class       = "db.t4g.micro"
  family               = "mysql8.0"

  allocated_storage = "20"
  storage_encrypted = true

  db_name  = "mydb"
  username = "admin"
  password = "YourSecurePassword!"
  port     = "3306"

  vpc_id        = module.vpc.id
  allowed_ip    = [module.vpc.vpc_cidr_block]
  allowed_ports = [3306]
  subnet_ids    = module.subnets.public_subnet_id

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
}
```

## Examples

| Example | Description |
|---------|-------------|
| [mysql-complete](./example/mysql-complete) | Full MySQL setup with options, parameters, SSM |
| [mariaDb](./example/mariaDb) | MariaDB setup with private subnets |
| [postgreSQL](./example/postgreSQL) | PostgreSQL setup with CloudWatch logs |
| [oracle_db](./example/oracle_db) | Oracle EE CDB setup with BYOL |
| [replica-mysql](./example/replica-mysql) | MySQL with read replica |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.0 |
| aws | >= 5.0.0 |
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| name | Resource name | `string` | `""` |
| environment | Environment name | `string` | `""` |
| managedby | ManagedBy tag value | `string` | `"themanojkumawat"` |
| enabled | Enable/disable module | `bool` | `true` |
| engine | Database engine | `string` | `"mysql"` |
| engine_version | DB engine version | `string` | `""` |
| instance_class | RDS instance class | `string` | `null` |
| allocated_storage | Storage in GB | `string` | `null` |
| db_name | Database name | `string` | `null` |
| username | Master username | `string` | `null` |
| password | Master password (auto-generated if empty) | `string` | `null` |
| vpc_id | VPC ID | `string` | `""` |
| subnet_ids | List of subnet IDs | `list(string)` | `[]` |
| family | Parameter group family | `string` | `null` |
| deletion_protection | Enable deletion protection | `bool` | `true` |
| multi_az | Enable Multi-AZ | `bool` | `false` |
| skip_final_snapshot | Skip final snapshot | `bool` | `true` |
| enabled_replica | Create read replica | `bool` | `false` |
| replica_instance_class | Read replica instance class | `string` | `""` |
| ssm_parameter_endpoint_enabled | Store endpoint in SSM | `bool` | `false` |
| kms_key_enabled | Enable KMS encryption | `bool` | `true` |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_id | RDS instance ID |
| db_instance_arn | RDS instance ARN |
| db_instance_endpoint | Connection endpoint |
| db_instance_address | Hostname |
| db_instance_port | Port |
| db_instance_password | Master password (sensitive) |
| db_replica_id | Read replica ID |
| db_replica_endpoint | Read replica endpoint |
| db_subnet_group_id | Subnet group ID |
| db_parameter_group_id | Parameter group ID |
| db_option_group_id | Option group ID |
| security_group_id | Security group ID |
| kms_key_arn | KMS key ARN |
| ssm_parameter_endpoint | SSM parameter name |

## License

MIT
