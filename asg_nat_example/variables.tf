variable "region" {
    default = "eu-north-1"
}

variable "company" {
 default = "omakaupunki"
}

variable "environment" {
    default = "test"
}

variable "owner" {
    default = "Admin"
}

variable "name" {
    default = "test-default"
}

# VPC
variable "cidr_block" {
    type = string
}

# variable "cidrs" {
#     type = list
# }

variable "availability_zones" {
    type = list
}

variable "public_cidr_block" {
    type = list
}

variable "private_cidr_block" {
    type = list
}

variable "allow_cidr_blocks" {
    type = list
    description = "Specify cird block that is allowd to acces the LoadBalancer"
}

variable "destination_cidr_block" {
    type = string
    description = "Specify all traffic to be routed either trough Internet Gateway or NAT to access the internet"
}

variable "instance_type" {
    type = string
}