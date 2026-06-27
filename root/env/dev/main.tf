# create vpc
module "vpc" {
    source = "../../module/VPC"
    aws_region = var.aws_region
}

#create public subnets
module "subnets_1a" {
    source = "../../module/Subnets"
    vpc_id = module.vpc.aws_vpc_id
    cidr_block ="10.0.1.0/24"
    availability_zone = "${var.aws_region}a"
    name = "public-subnet-1a"
}

module "subnets_1b" {
    source = "../../module/Subnets"
    vpc_id = module.vpc.aws_vpc_id
    cidr_block ="10.0.2.0/24"
    availability_zone = "${var.aws_region}b"
    name = "public-subnet-1b"
}


#create private subnets
module "app_frontend_subnets_1a" {
    source = "../../module/APP_Frontend_Subnets"
    vpc_id = module.vpc.aws_vpc_id
    cidr_block ="10.0.3.0/24"
    availability_zone = "${var.aws_region}a"
    name = "app-frontend-subnet-1a"
}

module "app_frontend_subnets_1b" {
    source = "../../module/APP_Frontend_Subnets"
    vpc_id = module.vpc.aws_vpc_id
    cidr_block ="10.0.4.0/24"
    availability_zone = "${var.aws_region}b"
    name = "app-frontend-subnet-1b"
}



#create private subnets
module "app_backend_subnets_1a" {
    source = "../../module/APP_Backend_Subnets"
    vpc_id = module.vpc.aws_vpc_id
    cidr_block ="10.0.5.0/24"
    availability_zone = "${var.aws_region}a"
    name = "app-backend-subnet-1a"
}

module "app_backend_subnets_1b" {
    source = "../../module/APP_Backend_Subnets"
    vpc_id = module.vpc.aws_vpc_id
    cidr_block ="10.0.6.0/24"
    availability_zone = "${var.aws_region}b"
    name = "app-backend-subnet-1b"
}




#create internet gateway and route table
module "ig_gate" {
    source = "../../module/IG_gate"
    vpc_id = module.vpc.aws_vpc_id
    public_subnet_ids = [
    module.subnets_1a.public_subnet_id,
    module.subnets_1b.public_subnet_id
    ]
    aws_region = var.aws_region
}

module "nat_gateway" {
  source = "../../module/NAT_gate"

  vpc_id            = module.vpc.aws_vpc_id
  public_subnet_id  = module.subnets_1a.public_subnet_id
  private_subnet_ids = [
    module.app_frontend_subnets_1a.app_frontend_subnet_id,
    module.app_frontend_subnets_1b.app_frontend_subnet_id,
    module.app_backend_subnets_1a.app_backend_subnet_id,
    module.app_backend_subnets_1b.app_backend_subnet_id
  ]
}

#create security group
module "security_group" {
    source = "../../module/SecurityGroup"
    vpc_id = module.vpc.aws_vpc_id
    aws_region = var.aws_region
    protocol = var.protocol
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

#careate key pair
module "KeyGeneration" {
    source = "../../module/KeyGeneration"
   key_name = "bastion_key"
}



#create bastion host
module "bastion_host" {
    source = "../../module/BastionHost"
    public_subnet_id = module.subnets_1a.public_subnet_id
    bastion_ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    key_name = module.KeyGeneration.key_pair_name
    vpc_security_group_ids = [module.security_group.security_group_id]
    name = "bastion-host"
    
}