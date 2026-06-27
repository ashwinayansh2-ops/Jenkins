variable "key_name" {
    description = "The name of the key pair to use for the bastion host"
    type        = string
    default     = "my-key-pair" # Replace with your actual key pair name    
}

variable "aws_region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}