terraform {
    required_version = ">= 0.13.0"
    required_providers {
        digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.2.0"
        }
    }
}

terraform {
}

variable "pvt_key" {}
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}
