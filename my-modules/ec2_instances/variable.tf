variable "my-subnet_ids" {
  description = "List of Subnet IDs"
  type        = list(string)
}


variable "security_group_id" {
  description = "Security Group ID"
}


variable "ami_id" {
  description = "AMI ID"
}


variable "instance_type" {
  description = "EC2 instance type"
}


variable "instance_names" {
    type = list(string)
    description = "List of instance names"
}