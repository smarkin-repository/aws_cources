# Configure the AWS Provider
provider "aws" {
    region           = var.aws_region
}

locals {
    tags = {
        "Owner" = var.owner
        "Environment" = var.environment
        "Company" = var.company
        "Stack" = var.stack
    }
}

module "vpc" {
    source = "./modules/vpc"
    company = var.company
    environment = var.environment
    name = var.vpc_name
    owner = var.owner
}


module "asg" {
    source = "./modules/asg"
}

module "iam" {
    source = "./modules/iam"
}

module "sg" {
    source = "./modules/sg"
}

module "ssm" {
    source = "./modules/ssm"
}

module "sg" {
    source = "./modules/sg"
}