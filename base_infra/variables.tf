variable "instance_type" {
 default = "t2.micro"
}

variable "aws_region" {
 default = "eu-north-1"
}

variable "company" {
 default = "hyva.paiva"
}

variable "environment" {
    default = "stg"
}

variable "vpc_name" {
    default = "main vpc"
}

variable "tfstate_bucket" {
    default = "omakaupunkitfstate"
}

variable "owner" {
    default = "admin"
}