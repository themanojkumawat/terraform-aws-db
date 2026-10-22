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
module "subnets" {
  source              = "git::https://github.com/themanojkumawat/terraform-aws-subnet.git?ref=master"
  name                = "app"
  environment         = "dev"
  managedby           = "themanojkumawat"
  availability_zones  = ["ap-south-1a", "ap-south-1b"]
  vpc_id              = module.vpc.id
  type                = "public-private"
  nat_gateway_enabled = true
  igw_id              = module.vpc.igw_id
  cidr_block          = module.vpc.vpc_cidr_block
}

##-----------------------------------------------------------------------------
## MariaDB
##-----------------------------------------------------------------------------
module "mariadb" {
  source      = "../../"
  name        = "mariadb"
  environment = "dev"
  managedby   = "themanojkumawat"
  repository  = "https://github.com/themanojkumawat/terraform-aws-db"

  # Engine
  engine               = "MariaDB"
  engine_name          = "mariadb"
  engine_version       = "11.4"
  major_engine_version = "11.4"
  instance_class       = "db.t4g.micro"
  family               = "mariadb11.4"

  # Storage
  allocated_storage = "20"
  storage_type      = "gp2"
  storage_encrypted = true

  # Database
  db_name  = "mariatest"
  username = "admin"
  password = "MariaSecure@1234"
  port     = "3306"

  # Network
  vpc_id        = module.vpc.id
  allowed_ip    = [module.vpc.vpc_cidr_block]
  allowed_ports = [3306]
  subnet_ids    = module.subnets.private_subnet_id

  # Backup & Maintenance
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false
}

##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "db_endpoint" {
  value = module.mariadb.db_instance_endpoint
}

output "db_instance_id" {
  value = module.mariadb.db_instance_id
}
