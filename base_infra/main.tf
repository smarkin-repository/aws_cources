# Configure the Azure Provider
provider "aws" {
    version          = "2.70"
    region           = var.aws_region
}

module "vpc" {
    source = "./modules/vpc"
    company = var.company
    environment = var.environment
    name = var.vpc_name
    owner = var.owner
}
