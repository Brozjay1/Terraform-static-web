variable "vpc_id" {
    description = "VPC ID"
}


variable "subnet_cidrs" {
    type = list(string)
}


variable "subnet_name_prefix" {
    type = string
}


variable "availability_zones" {
    description = "Availability zones"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b"  ]
}