terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.1"
        }
    }
}


provider "aws" {
    region = var.region
}


module "vpc" {
    source = "./my-modules/VPC"
    vpc_cidr = var.vpc_cidr
    vpc_name = "my-vpc"
}


module "subnets" {
    source = "./my-modules/subnets"
    vpc_id = module.vpc.vpc_id
    subnet_cidrs = var.subnet_cidrs
    subnet_name_prefix = "my-subnet"
}


module "route_table" {
    source = "./my-modules/route_table"
    vpc_id = module.vpc.vpc_id
    igw_id = module.internet_gateway.internet_gateway_id
    my-subnets_ids = module.subnets.subnet_ids
}


module "security_group" {
    source = "./my-modules/security_group"
    vpc_id = module.vpc.vpc_id
}


module "internet_gateway" {
    source = "./my-modules/internet_gateway"
    vpc_id = module.vpc.vpc_id
    internet_gateway_name = "my-igw"
}


module "ec2_instances" {
    source = "./my-modules/ec2_instances"
    my-subnet_ids = module.subnets.public_subnet_ids
    security_group_id = module.security_group.security_group_id
    ami_id = var.ami_id
    instance_type = var.instance_type
    instance_names = ["my-web1", "my-web2"]  
}