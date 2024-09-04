output "vpc_id" {
    value = module.vpc.vpc_id
}


output "my-subnet_ids" {
    value = module.subnets.subnet_ids
}


output "security_group_id" {
    value = module.security_group.security_group_id
}


output "route_table_id" {
    value = module.route_table.route_table_id
}


output "internet_gateway_id" {
    value = module.internet_gateway.internet_gateway_id
}


output "ec2_instances_info" {
    value = module.ec2_instances.instance_info
}