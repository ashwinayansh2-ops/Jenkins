
variable "public_subnet_id" {
    description = "The ID of the public subnet"
    type        = string  
}

variable "bastion_ami" {
    description = "The AMI ID for the Bastion host"
    type        = string    
}

variable "instance_type" {
    description = "The instance type for the Bastion host"
    type        = string
}

variable "key_name" {
    description = "The name of the key pair to use for SSH access"
    type        = string
}

variable "vpc_security_group_ids" {
    description = "List of security group IDs to associate with the Bastion host"
    type        = list(string)
}

variable "name" {
    description = "The name tag for the Bastion host"
    type        = string
}

variable "aws_region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}