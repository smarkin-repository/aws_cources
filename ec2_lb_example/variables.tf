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

variable "database_cidr_block" {
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

variable "key_name" {
    type = string
    description = "(optional) describe your variable"
}

variable "hc_target" {
    type = string
    description = "(optional) describe your variable"
}

# variable "healthcheck_lb" {
#     type = map
#     description = "(optional) describe your variable"
# }

variable "port" {
    type = string
    default = 80
}

variable "hc_port" {
    type = string
    default = 80
}

variable "hc_path" {
    type = string 
    default = "/"
}

variable "max_size" {
    type = string
    default = "2"
}

variable "min_size" {
    type = string
    default = "1"
}

variable "desired_capacity" {
    type = string
    default = "1"
}

variable "dns_name" {
    type = string
    default = "test"
}

variable "zone_id" {
    type = string
    default = "test"
}