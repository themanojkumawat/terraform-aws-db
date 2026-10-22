provider "aws" {
  region = "ap-south-1"
}

##-----------------------------------------------------------------------------
## VPC
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "git::https://github.com/themanojkumawat/terraform-aws-vpc.git?ref=master"
  name        = "app"
  environment = "dev"
  managedby   = "themanojkumawat"
  cidr_block  = "10.0.0.0/16"
}

##-----------------------------------------------------------------------------
## Subnets
##-----------------------------------------------------------------------------
module "subnets" {
  source             = "git::https://github.com/themanojkumawat/terraform-aws-subnet.git?ref=master"
  name               = "app"
  environment        = "dev"
  managedby          = "themanojkumawat"
  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  vpc_id             = module.vpc.id
  type               = "public"
  igw_id             = module.vpc.igw_id
  cidr_block         = module.vpc.vpc_cidr_block
}

##-----------------------------------------------------------------------------
## MySQL with Read Replica
##-----------------------------------------------------------------------------
module "mysql" {
  source      = "../../"
  name        = "rds"
  environment = "dev"
  managedby   = "themanojkumawat"
  repository  = "https://github.com/themanojkumawat/terraform-aws-db"

  # Engine
  engine               = "mysql"
  engine_name          = "mysql"
  engine_version       = "8.0.40"
  major_engine_version = "8.0"
  instance_class       = "db.t4g.micro"
  family               = "mysql8.0"

  # Storage
  allocated_storage = "20"
  storage_type      = "gp2"
  storage_encrypted = true

  # Database
  db_name  = "replicatest"
  username = "user"
  password = "ReplicaSecure@1234"
  port     = "3306"

  # Network
  vpc_id              = module.vpc.id
  allowed_ip          = [module.vpc.vpc_cidr_block]
  allowed_ports       = [3306]
  subnet_ids          = module.subnets.public_subnet_id
  publicly_accessible = true

  # Backup & Maintenance
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false

  # Read Replica config
  enabled_read_replica   = true
  enabled_replica        = true
  replica_instance_class = "db.t4g.micro"

  # Logs
  enabled_cloudwatch_logs_exports = ["audit", "general"]

  ssm_parameter_endpoint_enabled = true
}

##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "db_primary_endpoint" {
  value = module.mysql.db_instance_endpoint
}

output "db_replica_endpoint" {
  value = module.mysql.db_replica_endpoint
}

output "db_instance_id" {
  value = module.mysql.db_instance_id
}

output "db_replica_id" {
  value = module.mysql.db_replica_id
}
