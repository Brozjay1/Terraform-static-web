output "public_ips" {
  value = aws_instance.my-web[*].public_ip
}


output "instance_info" {
  value = {
    ids  = aws_instance.my-web.*.id
    ips  = aws_instance.my-web.*.public_ip
    tags = aws_instance.my-web.*.tags
  }
}
