module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.cidr_block
  tags = var.vpc_tags
  sub_cidr_block = var.sub_cidr_block
  sub1_tags = var.sub1_tags
}

module "sg" {
    source = "./modules/securitygroup"
    sg_name        = var.sg_name
    sg_description = var.sg_description

    vpc_id = module.vpc.vpc_id
  
}

module "ec2" {
    source = "./modules/ec2"

    ami           = var.ami
    instance_type = var.instance_type
    sub1_id       = module.vpc.sub1_id
    sg_id         = module.sg.sg_id
    ec2_tags      = var.ec2_tags
}

# terraform.tfvars
#         │
#         ▼
# Root Module
#         │
#         ▼
# VPC Module
#         │
#         ├── Creates VPC
#         ├── Creates Subnet
#         │
#         ├── Outputs:
#         │      vpc_id
#         │      sub1_id
#         │
#         ▼
# Security Group Module
#         │
#         │ Input:
#         │   module.vpc.vpc_id
#         │
#         ├── Creates SG
#         │
#         ├── Outputs:
#         │      sg_id
#         │
#         ▼
# EC2 Module
#         │
#         │ Input:
#         │   module.vpc.sub1_id
#         │   module.sg.sg_id
#         │
#         ▼
# Creates EC2
# This is the standard pattern you'll see in real production Terraform projects. Once you understand this flow of outputs from one module → passed by the root module → used as inputs to another module, the rest of module-based Terraform becomes much easier.
# Your execution order

# Terraform will create resources in this order:
# # VPC Module
#       │
#       ▼
# Creates:
# - VPC
# - Subnet

#       │
#       │ outputs
#       ▼
# Security Group Module
#       │
#       ▼
# Creates:
# - Security Group

#       │
#       │ outputs
#       ▼
# EC2 Module
#       │
#       ▼
# Creates EC2