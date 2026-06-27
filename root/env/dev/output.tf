/*
output "vpc_id" {
    value = module.vpc.aws_vpc_id
}


output "public_subnet_ids" {
  value = [module.subnets_1a.public_subnet_ids, module.subnets_1b.public_subnet_ids]
}


output "public_subnet_ids" {
  value = [
    module.subnets_1a.public_subnet_id,
    module.subnets_1b.public_subnet_id
  ]
}
*/