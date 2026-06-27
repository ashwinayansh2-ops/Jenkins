variable "vpc_id" {
    description = "The ID of the VPC to create subnets in"
    type        = string    
}

variable "cidr_block" {
    description = "The CIDR block for the subnet"
    type        = string
  
}

variable "name" {
    description = "The name of the subnet"
    type        = string
}

variable "aws_region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}

variable "availability_zone" {
    description = "The availability zone for the subnet"
    type        = string
}