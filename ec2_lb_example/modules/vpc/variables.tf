variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "tags" {
    type = map

    default = {
        Environment = "dev"
        Owner = "test"
        Company = "omakaupunki"
  }
}

variable "destination_cidr_block" {
    type = string
    description = "(optional) describe your variable"
}