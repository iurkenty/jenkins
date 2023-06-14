
variable "my_ip" {
  type        = string
  description = "My ip to be used for the security group"
}
variable "instance_type" {
    type        = string
    description = "EC2 instance type to be used for Jenkins server"  
}
variable "ami_owner" {
    type        = string
    description = "AMI owner id"
}
variable "ami_name" {
    type        = string
    description = "Name to be used to filter out the AMI"
}
variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}
variable "main_network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
}
variable "public_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to be used in public subnets"
}
variable "private_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to be used in private subnets"
}
variable "azs" {
  type        = list(string)
  description = "List of Availability Zones to be used"
}
variable "zone_name" {
  type        = string
  description = "My hosted zone"
}
variable "aws_region" {
  type        = string
  description = "AWS region for infrastructure to be deployed in" 
}