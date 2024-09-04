variable "vpc_id" {
    description = "VPC ID"
}


variable "igw_id" {
    description = "Internet Gateway ID"  
}


variable "my-subnets_ids" {
    description = "List of Subnet IDs"
    type = list(string)
}