provider "aws" {
  region = local.region
}

locals {
  name   = "example-vpc"
  region = "eu-west-1"
  tags = {
    Owner       = "user"
    Environment = "staging"
  }
  vpc_tags = {
    Name        = "example-vpc-name"
  }
  default_route_table_tags = {
    Name        = "default-rt"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../"

  name = local.name
  cidr = "10.0.0.0/20"

  azs               = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets   = ["10.0.0.0/23", "10.0.2.0/23", "10.0.4.0/23"]
  public_subnets    = ["10.0.6.0/26", "10.0.6.64/26", "10.0.6.128/26"]
  database_subnets  = ["10.0.7.0/26", "10.0.7.64/26", "10.0.7.128/26"]
  connect_subnets   = ["10.0.8.0/26", "10.0.8.64/26", "10.0.8.128/26"]
# dmz should be optional:
  dmz_subnets       = ["10.0.9.0/26", "10.0.9.64/26", "10.0.9.128/26"]

  enable_dns_hostnames  = true
  enable_dns_support    = true

  enable_nat_gateway    = true
  single_nat_gateway    = true

  enable_dhcp_options   = true

  tags = local.tags
  vpc_tags = local.vpc_tags
  default_route_table_tags = local.default_route_table_tags

}