variable "vpc_id" {
    description = "The ID of the VPC to create subnets in"
    type        = string    
}

variable "aws_region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "The IDs of the private subnets"
}

variable "public_subnet_id" {
  type = string
  default = "0.0.0.0/0"
}