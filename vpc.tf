provider "aws" {
  region = "us-west-2"
}

data "aws_availability_zones" "available" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "${var.env_prefix}-vpc"
  cidr = var.vpc_cidr_block
  azs  = data.aws_availability_zones.available.names

  public_subnets  = var.public_subnet_cidr_block
  private_subnets = var.private_subnet_cidr_block

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                              = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                     = "1"
  }

  tags = {
    "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
    "Environment"                                         = "dev"
    "Terraform"                                           = "true"
  }
}



# provider "aws" {
#   region = "us-west-2"  
# }

# data "aws_availability_zones" "myapp-azs" {
#   state = "available"
# }

# # variable avail_zone {}
# variable env_prefix {}
# variable vpc_cidr_block {}
# # variable subnet_cidr_block {}
# variable public_subnet_cidr_block {}
# variable private_subnet_cidr_block {}
# variable my_IP {}

# module "myapp-vpc" {
#     source  = "terraform-aws-modules/vpc/aws"
#     version = "6.0.1"

#     name = "${var.env_prefix}-vpc"
#     cidr = var.vpc_cidr_block 
#     azs  = data.aws_availability_zones.myapp-azs.names
#     public_subnets = var.public_subnet_cidr_block
#     private_subnets = var.private_subnet_cidr_block

#     enable_nat_gateway = true
#     single_nat_gateway = true
#     enable_dns_hostnames = true
#     enable_dns_support = true

#     tags = {
#         "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
#     }

#     public_subnet_tags = {
#         "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
#         "kubernetes.io/role/elb" = 1
#     }

#     private_subnet_tags = {
#         "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
#         "kubernetes.io/role/internal-elb" = 1
#     }
# }