resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx

              systemctl enable nginx
              systemctl start nginx

              cat > /usr/share/nginx/html/index.html <<HTML
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Welcome</title>
              </head>
              <body>
                  <h1>Hello Shashi</h1>
              </body>
              </html>
              HTML
              EOF

  tags = {
    Name = var.name
  }
}