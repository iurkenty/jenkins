# Jenkins-Terraform-Ansible-AWS 
This is project will do the following:

1. Provision a VPC across 3 azs with two private and one public subnets.
2. Provision an EC2 of t3.medium size.
3. Create a CNAME record in your DNS using Route53 (Hosted Zone must be created separetelly).
4. Create an SSH key.
5. Install Jenkins using Ansible.
6. Display the initial admin password for Jenkins.

# Prerequisites
Before you can use this project, you'll need to have the following installed on your local machine:

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

# Usage
To use this project, follow these steps:

1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Run **terraform init** to initialize the Terraform configuration.
4. Run **terraform apply** to create the infrastructure and configure it using Ansible.

# Conclusion
You should now have Jenkins running at 'jenkins.<domain-name> and be able to use the initial admin password to log in.