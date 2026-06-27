# Create a security group for the external ALB
resource "aws_security_group" "external_alb" {
  name        = "external-alb-sg"
  description = "External ALB Security Group"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = [80,443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol
      cidr_blocks =["0.0.0.0/0"]
      description = "Allow port ${ingress.value}"
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create a security group for the internal ALB
resource "aws_security_group" "internal_alb" {
  name   = "internal-alb-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = [80,443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol
      security_groups = [ aws_security_group.external_alb.id ]
      description = "Allow port ${ingress.value}"
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for the bastion host
resource "aws_security_group" "bastion" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = [8080,22]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for the private EC2 instances
resource "aws_security_group" "private_ec2" {
  name   = "private-ec2-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
  for_each = [8080,22]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = var.protocol
      security_groups = [aws_security_group.internal_alb.id]
      description = "Allow port ${ingress.value}"
    }
    
  }

  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for the database
resource "aws_security_group" "database" {
  depends_on = [ aws_security_group.private_ec2 ]
  name   = "database-sg"
  vpc_id = var.vpc_id

  ingress {
    description     = "MySQL from App Servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = var.protocol
    security_groups = [aws_security_group.private_ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}