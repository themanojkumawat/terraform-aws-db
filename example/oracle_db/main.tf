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
## Subnets (public-private for NAT)
##-----------------------------------------------------------------------------
module "private_subnets" {
  source              = "git::https://github.com/themanojkumawat/terraform-aws-subnet.git?ref=master"
  name                = "app"
  environment         = "dev"
  managedby           = "themanojkumawat"
  nat_gateway_enabled = true
  availability_zones  = ["ap-south-1a", "ap-south-1b"]
  vpc_id              = module.vpc.id
  type                = "public-private"
  igw_id              = module.vpc.igw_id
  cidr_block          = module.vpc.vpc_cidr_block
}

##-----------------------------------------------------------------------------
## Oracle DB
##-----------------------------------------------------------------------------
module "oracle" {
  source      = "../../"
  name        = "oracle"
  environment = "dev"
  managedby   = "themanojkumawat"
  repository  = "https://github.com/themanojkumawat/terraform-aws-db"

  # Engine
  engine               = "oracle-ee-cdb"
  engine_name          = "oracle-ee-cdb"
  engine_version       = "19.0.0.0.ru-2024-07.rur-2024-07.r1"
  major_engine_version = "19"
  instance_class       = "db.t3.medium"
  family               = "oracle-ee-cdb-19"
  license_model        = "bring-your-own-license"

  # Storage
  allocated_storage = "20"
  storage_type      = "gp2"
  storage_encrypted = true

  # Database
  db_name  = null  # Oracle CDB does not support db_name at instance creation
  username = "admin"
  password = "OracleSecure@1234"
  port     = "1521"

  # Network
  vpc_id        = module.vpc.id
  allowed_ip    = [module.vpc.vpc_cidr_block]
  allowed_ports = [1521]
  subnet_ids    = module.private_subnets.private_subnet_id

  # Backup & Maintenance
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false

  # IAM auth not supported by Oracle
  iam_database_authentication_enabled = false
}

##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "db_endpoint" {
  value = module.oracle.db_instance_endpoint
}

output "db_instance_id" {
  value = module.oracle.db_instance_id
}
