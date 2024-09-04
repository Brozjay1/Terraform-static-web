resource "aws_instance" "my-web" {
  count          = 2
  ami            = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = element(var.my-subnet_ids, count.index)
  security_groups = [var.security_group_id]

  tags = {
    Name = var.instance_names[count.index]
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              echo "<html><h1>Brozjay welcome you to the Web Server ${count.index + 1}</h1></html>" > /var/www/html/index.html
              systemctl start apache2
              systemctl enable apache2
              EOF
}