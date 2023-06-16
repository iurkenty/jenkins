module "jenkins" {
  source = "./jenkins/"

  name_prefix             = var.name_prefix
  main_network_block      = var.main_network_block
  public_cidr_blocks      = var.public_cidr_blocks
  private_cidr_blocks     = var.private_cidr_blocks
  azs                     = var.azs
  zone_name               = var.zone_name
  instance_type           = var.instance_type
  ami_owner               = var.ami_owner
  ami_name                = var.ami_name
  ansible_ssh_key         = var.ansible_ssh_key 
  ansible_user            = var.ansible_user
}