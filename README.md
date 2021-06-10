# Terraform Module VPC

## Maintainer

* Platform Services

## Author

* Sophie Sleurink

## Version

Current version: v0.0.1

## Description

This module creates the VPC and some related resources.

## Usage

Describe how to use your module here.

Minimum required input is:

################################################################################
# Provider / Locals 
################################################################################
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
# dmz is optional:
  # dmz_subnets       = ["10.0.9.0/26", "10.0.9.64/26", "10.0.9.128/26"]

  tags = local.tags

}

## Prerequites

If there are any prerequistes to making this module work, add them here.

### Optional

* [pre-commit](https://pre-commit.com/#install)
    * Install the pre-commit hooks in the mod repo using

      ```(text)
      pre-commit install
      ```

* Python3 & pip
    * Any addtional pip modules should be added to requirements.txt

## Documentation

[confluence](https://ohpendev.atlassian.net/wiki/spaces/CCE/pages/2062320795/Terraform+Modules)

