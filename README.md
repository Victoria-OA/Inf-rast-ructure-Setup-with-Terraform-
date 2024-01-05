# Alt-Assignment
### Infrastructure with Terraform

Welcome to the Infrastructure with Terraform repository. This repository contains Terraform code to set up and manage infrastructure components. Below is a brief overview of the files included in this repository:

- `ansible.cfg`: This file contains configuration settings for Ansible, a tool used for configuration management and application deployment.
- `datasources.tf`: In this file, you can define Terraform data sources, which allow you to reference data that is defined and managed outside of Terraform, such as existing resources in your cloud provider.
- `host-inventory`: This file serves as an inventory file for Ansible, listing the hosts or servers that Ansible will manage.
- `main.tf`: The main Terraform configuration file where you define the infrastructure resources, such as virtual machines, networks, and storage, using Terraform's declarative configuration language.
- `output.tf`: Here, you can define the outputs of your Terraform configuration, which are values that can be queried or displayed after the infrastructure is created.
- `provider.tf`: This file is used to configure the Terraform provider, which defines the cloud provider (such as AWS, Azure, or GCP) and any required authentication details.
- `route53.tf`: In this file, you can define resources related to Amazon Route 53, which is a scalable and highly available Domain Name System (DNS) web service provided by AWS.
- `script.yml`: This is an Ansible playbook, which is a YAML file that defines a series of tasks to be executed by Ansible on the hosts listed in the inventory file.
- `variables.tf`: This file is used to define input variables for your Terraform configuration, which can be used to parameterize and customize the infrastructure.
### Conclusion
The project is a mini-project and is intended for learning and demonstration purposes. It is a work in progress and may be updated over time.
