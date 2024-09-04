resource "aws_subnet" "my-subnet" {
    count = length(var.subnet_cidrs)
    vpc_id = var.vpc_id
    cidr_block = var.subnet_cidrs[count.index]
    map_public_ip_on_launch = true
    availability_zone = element(var.availability_zones, count.index)

    tags = {
      Name = "${var.subnet_name_prefix}-${count.index +1}"
    }
}