variable "name" {
    type = string
}

variable "description" {
    type = string
    default = "the default sg to allow all trafic to target subnets"
}

variable "tags" {
    type = map
}

variable "allow_cidr_blocks" {
    type = list
    default = ["0.0.0.0/0"]
    description = "Specify cird block that is allowd to acces default"
}

variable "vpc_id" {
    type = string
}