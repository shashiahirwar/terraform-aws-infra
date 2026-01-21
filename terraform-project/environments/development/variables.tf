# environments/production/variables.tf
# variable "aws_access_key" {
#   type      = string
#   sensitive = true
# }

# variable "aws_secret_key" {
#   type      = string
#   sensitive = true
# }
variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  # default     = "us-east-1"
}
variable "name" {
    type = string
    description = "set the name of vpc"
    default = "myvpc"
  
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-08a6efd148b1f7504" # Example AMI ID, replace with a valid one
  
}
variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
  
}
variable "ingress_rules"{
  type = list(number)
    description = "List of ingress rules for the security group"
    default = [22, 80, 443] # Example ports, replace with actual requirements
}
variable "egress_rules" {
  type = list(number)
  description = "List of egress rules for the security group"
  default = [0] # Example rule, replace with actual requirements
}
