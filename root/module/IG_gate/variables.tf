variable "aws_region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}

variable "vpc_id" {
    description = "The ID of the VPC to create subnets in"
    type        = string    
}
variable "public_subnet_ids" {
    description = "The IDs of the public subnets"
    type        = list(string)    
}