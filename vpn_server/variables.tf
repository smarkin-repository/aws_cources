variable "name" {
  default = "web-1"
}


variable "owner" {
  default = "dx011"
}

variable "region" {
  description = "Frankfurt, Germany"
  default = "fra1"
}

variable "size" {
  default = "s-1vcpu-1gb"
}

variable "ip_range" {
  default = "172.16.0.0/24"
}

variable "ssh_key_name" {
    description = ""
    default = "test"
}

variable "domain" {
  description = "value"
}