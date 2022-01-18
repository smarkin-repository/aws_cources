variable "cidrs" {
    type = list
}

variable "availability_zones" {
    type = list
}

variable "vpc_id" {
    type = string
}

variable "tags" {
    type = map

    default = {
        Environment = "dev"
        Owner = "test"
        Company = "omakaupunki"
  }
}

variable "name" {
    type = string
}