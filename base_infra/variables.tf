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
}

variable "vpc_name" {
    default = "main"
}

variable "tfstate_bucket" {
    default = "omakaupunkitfstate"
}

variable "owner" {
}

variable "stack" {
}