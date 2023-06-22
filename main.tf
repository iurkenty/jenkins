module "jenkins" {
  source = "./jenkins/"

  name_prefix             = var.name_prefix
  main_network_block      = var.main_network_block
  public_cidr_blocks      = var.public_cidr_blocks
  private_cidr_blocks     = var.private_cidr_blocks
  azs                     = var.azs
  zone_name               = var.zone_name
  instance_type           = var.instance_type
  ami_owner               = var.ami_owner[1] //[0]-Ubuntu & [1]-Amazon Linux 2
  ami_name                = var.ami_name[1] //[0]-Ubuntu & [1]-Amazon Linux 2
  ansible_user            = var.ansible_user[1] //[0]-ubuntu & [1]-ec2-user
  ansible_playbook        = var.ansible_playbook[1] //[0]-ping.yaml & [1]-jenkins.yaml
  ansible_ssh_key         = var.ansible_ssh_key 
}