#create internet gateway
resource "aws_internet_gateway" "main" {
    vpc_id = var.vpc_id

    tags = {
        Name = "main-internet-gateway"
    }
}



#create route table
resource "aws_route_table" "public" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "public-route-table"
    }
}

# associate the public route table with all public subnets from the VPC module
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

