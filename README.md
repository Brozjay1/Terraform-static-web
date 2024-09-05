INFRASTRUCTURE PROJECT WITH TERRAFORM USING MODULE DIRECTORY STRUCTURE

# PROJECT OVERVIEW
The project uses Terraform to provision an AWS infrastructure that includes the following components:

- VPC
- Public Subnets: is within the VPC
- Route Table: will have routes to the internet via an Internet Gateway
- Internet Gateway: is attached to the VPC
- Security Group: will allow HTTP and SSH traffic
- EC2 Instances: will host a static website

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

### Directory and Files

## ROOT DIRECTORY
- `init-main.tf`: The root configuration file that orchestrates the modules.
- `init-variables.tf`: Contains variable definitions used across the project.
- `init-outputs.tf`: Defines the outputs to be returned by the root module.

## my-modules directory**
- `vpc/`: Contains configurations for creating the VPC.
- `subnets/`: Manages the creation of subnets within the VPC.
- `route_table/`: Configures the route table and its associations with subnets and the internet gateway.
- `security_group/`: Defines the security group that controls inbound and outbound traffic.
- `ec2_instances/`: Launches and configures EC2 instances to host a static website.
 
## Prerequisites

- Terraform: installed on your local machine.
- AWS CLI: configured with your credentials.

## Usage

### 1. Initialize Terraform
To initialize the Terraform working directory:
`terraform init`

### 2. Validating the Configuration File
To check if the configuration does not any error
`terraform validate`

### 3. Plan the Infrastructure
To review the plans of the configurations
`terraform plan`

### 4. Apply the Configuration
To excute the configuration for the infrastructure:
`terraform apply`

### 4. Access the Static Website
After the EC2 instances are created you can access the static website by entering the public IP address of each instance in a web browser:
`http://<instance-public-ip-address>`

## Outputs
After applying the configuration, the followin  will be the outcome:

- VPC ID: The ID of the created VPC
- Subnet IDs: The IDs of the created subnets
- Instance Info: Public IPs and instance IDs of the created EC2 instances

## destroyong infastructure
To destroy the created infrastructure and avoid costs on AWS console
`terraform destroy`

- NOTE: This overview on Terraform project, helps users understand the project structure, configuration, and how to use it.

______________________________________________________________________________________________________________________________________________________________________
This part shows the details of my project with GitHub Actions CI/CD pipeline to deploy a static website on AWS EC2 instances.

#  DEPLOYING WITH GITHUB ACTIONS TERRAFORM STATIC WEBSITE

This project demonstrates the deployment of a static website hosted on AWS EC2 instances using Terraform and an automated CI/CD pipeline through GitHub Actions.
The setup involves creating a VPC, subnets, route table, security group, internet gateway, EC2 instances, and deploying a simple static website to the EC2 instances.

## Updated Project Structure

```
├── my-modules/
│   ├── VPC/
│   ├── subnets/
│   ├── route_table/
│   ├── security_group/
│   ├── internet_gateway/
├── .github/
│   ├── workflows/
│       ├── web_deploy.yaml
├── static_website/
│   ├── index.html
├── init-main.tf
├── init-variables.tf
├── init-outputs.tf
└── README.md
```

## Prerequisites
- Terraform installed
- AWS account
- AWS Access Key ID and Secret Access Key
- SSH key for connecting to EC2 instances

## SETUPS

### 1. AWS Credentials
Know your AWS credentials using the AWS CLI with this command:
`cat ~/.aws/credentials`

Configure your AWS credentials locally using the AWS CLI:
`export AWS_ACCESS_KEY_ID=your-access-key-id`
`export AWS_SECRET_ACCESS_KEY=your-secret-access-key`

For GitHub Actions, add the following secrets to your repository by clicking on Settings > Secrets and variables > Actions:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `SSH_PRIVATE_KEY`

### 2. Static Website
create a `static_website/` directory,which will include an `index.html` file.

### 3. GitHub Actions CI/CD Pipeline
make a directory `.github/` and sub-directory `workflows/` which will include `web_deploy.yaml` file to automates the deployment process.

### 4. Automation process
initialize,commit and push to the repo for the automation process by:
`git init`
`git add .`
`git commit -m "commit message"`
`git push origin master`

When you push changes to the `master` branch, the following steps occur:

1. Checkout code: Downloads the latest code from your repository.
2. Terraform Init: Initializes the Terraform configuration.
3. Terraform Plan: Plans the deployment changes.
4. Terraform Apply: Applies the changes to provision resources in AWS.
5. Deploy Website: Uploads the static website files from the `static_website/` directory to the EC2 instances.

### 5. Workflow File: `web_deploy.yaml`

```yaml
name: Deploying A static web using Terraform

on:
    push:
        branches:
            - master

jobs:
    terraform:
        name: Terraform Apply
        runs-on: ubuntu-latest

        steps:
            - name: Checkout Code
              uses: actions/checkout@v3

            - name: Set up Terraform
              uses: hashicorp/setup-terraform@v2
              with: 
                terraform_version: 1.9.5
            
            - name: Configure Aws credentials
              run: |
                mkdir -p ~/.aws
                echo "[default]"> ~/.aws/credentials
                echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >>~/.aws/credentials
                echo "aws_secret_access_key= $AWS_SECRET_ACCESS_KEY" >>~/.aws/credentials
              env:
                AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
                AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY}}

            - name: Initializing Terraform
              run:  terraform init
              env:
                AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
                AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY}}
                aws-region: us-east-1

            - name: Planning Terraform
              run:  terraform plan
              env:
                AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
                AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY}}
                aws-region: us-east-1

            - name: Applying Terraform
              run:  terraform apply --auto-approve
              env:
                AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
                AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY}}
                aws-region: us-east-1

    deploy_website:
        name:    Deploy website to EC2
        needs:   terraform
        runs-on: ubuntu-latest

        steps:
        - name: Checkout Code
          uses: actions/checkout@v3

        - name: Upload Website Files
          run:  |
            IP_ADDRESS=$(terraform output -raw instance_public_ips)
            for ip in $IP_ADDRESSES; do
                scp -o StrictHostKeyChecking=no -i "${ secrets.SSH_PRIVATE_KEY }" -r ./my-static-web/* ec2-user@ip:/var/www/html/
                done
          env:
            AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
            AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY}}
```

### 6. Access Your Website
Once the deployment is complete, you can access the static website by navigating to the public IP addresses of the EC2 instances.
The public IP addresses are available in GitHub Actions logs and AWS console.

## 7. Clean Up
To destroy the resources and avoid unnecessary charges from AWS, run this command:
`terraform destroy --auto-approve`

## Troubleshooting
- Ensure AWS credentials are properly set in GitHub Secrets.
- Check GitHub Actions logs for any errors during the deployment process.
- Verify that the EC2 instances are accessible via SSH and that the security group allows HTTP and SSH traffic.

## License
This project is licensed under the MIT License.


- NOTE:This `README.md` shows an understandable  guide to set up, deploy, and manage the project. You can reuse the terraform congfiguration file and also add any other project-specific details as needed
