// Variables
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
variable "ansible_ssh_key" {
    type        = string
    description = "Path to the pem file to be used by ansible"
}
variable "ansible_user" {
    type        = string
    description = "User name to be used by ansible" #See AMI docs for one
}
# Does not work with terraform cloud in remote mode
data "http" "my_ip" {
  url ="https://api.ipify.org"
}
// AMI
data "aws_ami" "ami" {
  most_recent = true
  owners      = [var.ami_owner] 
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
// SSH Key Pair
module "ssh_key" {
  source             = "terraform-aws-modules/key-pair/aws"
  key_name           = "${var.name_prefix}.pem"
  create_private_key = true
}
resource "aws_ssm_parameter" "ssh_key" {
  name        = "${var.name_prefix}-ssh-key"
  type        = "SecureString"
  value       = module.ssh_key.private_key_pem
}
// Does't work with terraform cloud
resource "local_file" "ssh_key" {
  filename        = "${var.name_prefix}.pem"
  content         = module.ssh_key.private_key_pem
  file_permission = "400"
}
// Security groups
module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name_prefix}-sg"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${data.http.my_ip.response_body}/32"]
  ingress_rules       = ["ssh-tcp", "http-8080-tcp"]
  egress_rules        = ["all-all"]
}
// EC2
module "compute" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.name_prefix
  ami                         = data.aws_ami.ami.id
  key_name                    = module.ssh_key.key_pair_name
  instance_type               = var.instance_type
  availability_zone           = module.vpc.azs[0]
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [module.jenkins_sg.security_group_id]
  associate_public_ip_address = true
  disable_api_stop            = false

  create_iam_instance_profile = false

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp3"
      throughput  = "300"
      volume_size = "50"
      tags = {
        Name = "${var.name_prefix}-root-volume"
      }
    }
  ]
}
/*
# Can't use it due to the error --> The plugin.(*GRPCProvider).ApplyResourceChange request was cancelled.
resource "ansible_playbook" "this" {
  name     = module.compute.public_ip
  playbook = "./ping.yaml"
}
// Ansible dynamic inventory
resource "ansible_host" "this" {
  name   = module.compute.public_ip
  groups = ["jenkins"]
  variables = {
    ansible_user                 = "ubuntu"
    ansible_ssh_private_key_file = var.ansible_ssh_key
  }
}
*/
// Ansible playbook
resource "null_resource" "playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${module.compute.public_ip}, --private-key ${var.ansible_ssh_key} -u ${var.ansible_user} ansible/ping.yaml"
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [module.compute]  
}

