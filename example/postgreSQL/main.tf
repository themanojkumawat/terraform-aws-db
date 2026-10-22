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
## PostgreSQL
##-----------------------------------------------------------------------------
module "postgresql" {
  source      = "../../"
  name        = "postgresql"
  environment = "dev"
  managedby   = "themanojkumawat"
  repository  = "https://github.com/themanojkumawat/terraform-aws-db"

  # Engine
  engine               = "postgres"
  engine_name          = "postgres"
  engine_version       = "16.3"
  major_engine_version = "16"
  instance_class       = "db.t3.micro"
  family               = "postgres16"

  # Storage
  allocated_storage = "20"
  storage_type      = "gp2"
  storage_encrypted = true

  # Database
  db_name  = "pgtest"
  username = "pgadmin"
  password = "PgSecure@1234"
  port     = "5432"

  # Network
  vpc_id        = module.vpc.id
  allowed_ip    = [module.vpc.vpc_cidr_block]
  allowed_ports = [5432]
  subnet_ids    = module.private_subnets.private_subnet_id

  # Backup & Maintenance
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false

  # PostgreSQL logs
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # Parameters
  parameters = [
    {
      name  = "max_connections"
      value = "100"
    }
  ]
}

##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "db_endpoint" {
  value = module.postgresql.db_instance_endpoint
}

output "db_instance_id" {
  value = module.postgresql.db_instance_id
}
