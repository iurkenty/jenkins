
variable "instance_type" {
  type        = string
  description = "EC2 instance type to be used for Jenkins server"  
}
variable "ami_owner" {
  type        = list(string)
  default     = ["099720109477", "137112412989"]
  description = "Canonical and Amazon account IDs"
}
variable "ami_name" {
  type        = list(string)
  default     = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*", "amzn2-ami-hvm-*-x86_64-gp2"]
  description = "AMI filter name"
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
variable "aws_profile" {
  type        = string
  description = "AWS profile for infrastructure to be used" 
}
variable "ansible_ssh_key" {
  type        = string
  description = "Path to the pem file to be used by ansible"
}
variable "ansible_user" {
  type        = list(string)
  default     = ["ubuntu", "ec2-user"]
  description = "User name to be used by ansible"
}
variable "ansible_playbook" {
  type        = list(string)
  default     = ["ansible/ping.yaml", "ansible/jenkins.yaml"]
  description = "Choose between Jenkins and Ping playbooks" 
}