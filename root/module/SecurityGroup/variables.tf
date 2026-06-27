variable "vpc_id" {
    description = "The ID of the VPC to create subnets in"
    type        = string    
}

variable "aws_region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}

variable "protocol" {
    description = "The protocol for the security group rule (e.g., tcp, udp, icmp)"
    type        = string
    default     = "tcp" 
}
