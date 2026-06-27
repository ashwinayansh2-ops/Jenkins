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

variable "instance_type" {
    description = "The instance type for the bastion host"
    type        = string
    default     = "t2.micro"
}

variable "bastion_ami" {
    description = "The AMI ID for the bastion host"
    type        = string
    default     = "ami-0c55b159cbfafe1f0" # Example AMI ID, replace with a valid one
}

variable "key_name" {
    description = "The name of the key pair to use for the bastion host"
    type        = string
    default     = "my-key-pair" # Replace with your actual key pair name
}