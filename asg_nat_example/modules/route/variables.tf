variable "igw_id" {
    type = string
}

variable "nat_ids" {
    type = list
}

variable "vpc_id" {
    type = string
}

variable "tags" {
    type = map
}

variable "private_rt_ids" {
    type = list
}

variable "public_rt_ids" {
    type = list
}

variable "destination_cidr_block" {
    type = string
}

