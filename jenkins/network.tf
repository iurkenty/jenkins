# Network variables
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

# get all available AZs in a region
data "aws_availability_zones" "available_azs" {
  state = "available"
  filter {
    name   = "zone-name"
    values = var.azs
  }
}
// Zone ID to be used for EC2 public DNS
data "aws_route53_zone" "the_zone" {
  name = var.zone_name
}

# create VPC using the public AWS module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "${var.name_prefix}-vpc"
  cidr = var.main_network_block
  azs  = data.aws_availability_zones.available_azs.names

  private_subnets = var.private_cidr_blocks
  public_subnets  = var.public_cidr_blocks

  enable_dns_hostnames = true
}
// EC2 public DNS record
module "route53" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.10.2"

  zone_id = data.aws_route53_zone.the_zone.zone_id

  records = [
    {
      name = var.name_prefix
      type = "CNAME"
      ttl  = 300
      records = [
        module.compute.public_dns
      ]
    }
  ]

}