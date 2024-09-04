---

# PROJECT OVERVIEW
The project uses Terraform to provision an AWS infrastructure that includes the following components:

- **VPC**
- **Public Subnets** is within the VPC
- **Route Table** have routes to the internet via an Internet Gateway
- **Internet Gateway** is attached to the VPC
- **Security Group** will allow HTTP and SSH traffic
- **EC2 Instances** will host a static website

## Modular Directory Structure

```
Terraform-Task/
│
├── init.main.tf
├── init.variables.tf
├── init.outputs.tf
│
├── vpc/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── subnets/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── route_table/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── internet_gateway/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
├── security_group/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
└── ec2_instances/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf

```

### Directory and Files Tasks

**ROOT DIRECTORY**
- **`init-main.tf`**: The root configuration file that orchestrates the modules.
- **`init-variables.tf`**: Contains variable definitions used across the project.
- **`init-outputs.tf`**: Defines the outputs to be returned by the root module.

**my-modules directory**
- **`vpc/`**: Contains configurations for creating the VPC.
- **`subnets/`**: Manages the creation of subnets within the VPC.
- **`route_table/`**: Configures the route table and its associations with subnets and the internet gateway.
- **`security_group/`**: Defines the security group that controls inbound and outbound traffic.
- **`ec2_instances/`**: Launches and configures EC2 instances to host a static website.
 
## Prerequisites

- **Terraform** installed on your local machine.
- **AWS CLI** configured with your credentials.

## Usage

### 1. Initialize Terraform

To initialize the Terraform working directory:

```bash
terraform init
```

### 2. Validating the Configuration File

To check if the configuration does not any error

```bash
terraform validate
```
### 3. Plan the Infrastructure


To review the plans of the configurations

```bash
terraform plan
```

### 4. Apply the Configuration

To excute the configuration for the infrastructure:

```bash
terraform apply
```

Confirm the apply action when you enter **yes**

### 4. Access the Static Website

After the EC2 instances are created you can access the static website by entering the public IP address of each instance in a web browser:

```
http://<instance-public-ip-address>
```

## Outputs

After applying the configuration, the followin  will be the outcome:

- **VPC ID**: The ID of the created VPC
- **Subnet IDs**: The IDs of the created subnets
- **Instance Info**: Public IPs and instance IDs of the created EC2 instances

## destroyong infastructure

To destroy the created infrastructure and avoid costs on AWS console

```bash
terraform destroy
```

Confirm the destroy action when you enter **yes**
---

This project overview on Terraform project, helps users understand the project structure, configuration, and how to use it.
