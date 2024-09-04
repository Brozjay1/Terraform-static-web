variable "region" {
   description = "Aws region"
   default = "us-east-1" 
}


variable "vpc_cidr" {
    description = "VPC CIDR BLOCK"
    default = "10.0.0.0/16"
}


variable "instance_type" {
    description = "ec2 instance type"
    default = "t2.micro"
}


variable "subnet_cidrs" {
    description = "List of CIDR blocks for the subnets"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}


variable "ami_id" {
    description = "AMI ID for ec2 instances "
    default = "ami-0e86e20dae9224db8" 
}


variable "instance_names" {
    type = list(string)
    description = "List of instance names"
    default = [ "my-web1", "my-web2" ]
}