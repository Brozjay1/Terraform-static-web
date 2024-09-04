resource "aws_route_table" "my-route" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw_id
    }
}


resource "aws_route_table_association" "my-subnets" {
    count = length(var.my-subnets_ids)
    subnet_id = var.my-subnets_ids[count.index]
    route_table_id = aws_route_table.my-route.id
}