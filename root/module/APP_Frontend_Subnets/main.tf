# create subnet
resource "aws_subnet" "app_frontend_subnet" {
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block
    availability_zone = var.availability_zone
    tags = {
      Name = var.name
    }
    
}



    

