output "subnet_ids" {
    value = aws_subnet.my-subnet[*].id
}


output "public_subnet_ids" {
    value = aws_subnet.my-subnet[*].id
}