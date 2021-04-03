# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
# Configure the DigitalOcean Provider

# Create a web server

resource "digitalocean_tag" "name" {
  name = "web-${var.name}"
}

resource "digitalocean_tag" "owner" {
  name = var.owner
}

resource "digitalocean_vpc" "this" {
  name     = "private-network-${var.name}"
  region   = var.region
  ip_range = var.ip_range
}

resource "digitalocean_droplet" "ec" {
    image = "ubuntu-18-04-x64"
    name = "ec-${var.name}"
    region = var.region
    size = var.size
    # private_networking = true
    monitoring         = true
    vpc_uuid = digitalocean_vpc.this.id
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
    connection {
      host = self.ipv4_address
      user = "root"
      type = "ssh"
      private_key = file(var.pvt_key)
      timeout = "2m"
    }
    # provisioner "remote-exec" {
    #   # why not scripts https://www.digitalocean.com/community/questions/want-to-install-monitoring-agent-but-i-am-getting-unable-to-lock-the-administration-directory-var-lib-dpkg-is-another-process-using-it ?
    #   inline = [
    #       "export PATH=$PATH:/usr/bin",
    #       "apt-get update",
    #       "apt-get -y install nginx",
    #       "ufw allow 'Nginx HTTP'",
    #       "ufw allow 'Nginx HTTPS'",
    #       "ufw allow 'OpenSSH'",
    #       "echo \"y\" | sudo ufw enable",
    #       "adduser ec-user --disabled-login --gecos \"\"",
    #       "usermod -aG sudo ec-user",
    #       "rsync --archive --chown=ec-user:ec-user ~/.ssh /home/ec-user"
    #   ]
    # }
    tags = [
      digitalocean_tag.name.id,
      digitalocean_tag.owner.id
    ]
}

# resource "digitalocean_loadbalancer" "public" {
#   name = "lb-${var.name}"
#   region = var.region

#   forwarding_rule {
#     entry_port = 80
#     entry_protocol = "http"

#     target_port = 80
#     target_protocol = "http"
#   }

#   healthcheck {
#     port = 22
#     protocol = "tcp"
#   }

#   # redirect_http_to_https = true # works only with  https and certificate

#   vpc_uuid = digitalocean_vpc.this.id
#   droplet_ids = [digitalocean_droplet.ec.id ]
# }


resource "digitalocean_firewall" "web" {
  name = "only-22-80-and-443"

  droplet_ids = [digitalocean_droplet.ec.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    # source_addresses = ["${digitalocean_loadbalancer.lb.ip}"]
    # source_addresses = ["0.0.0.0/0", "::/0"]
    source_addresses = ["213.108.139.99"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
    # source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
    # source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "5555"
    source_addresses = ["0.0.0.0/0", "::/0"]
    # source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

# allow ports for L2TP over IPsec
  inbound_rule {
    protocol         = "udp"
    port_range       = "500"
    source_addresses = ["0.0.0.0/0", "::/0"]
    # source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

    inbound_rule {
    protocol         = "udp"
    port_range       = "4500"
    source_addresses = ["0.0.0.0/0", "::/0"]
    # source_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "500"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "4500"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "5555"
    destination_addresses = ["0.0.0.0/0", "::/0"]
    # destination_load_balancer_uids = [digitalocean_loadbalancer.public.id]
  }
}


# resource "digitalocean_domain" "default" {
#    name = var.domain
#    ip_address = digitalocean_loadbalancer.public.ip
# }

# resource "digitalocean_record" "CNAME-www" {
#   domain = digitalocean_domain.default.name
#   type = "CNAME"
#   name = "www"
#   value = "@"
# }

# token:
# fingerprint: 4096 SHA256:QtLse1JI4CQfp3iFj+f+ES93NSfWpDKLNISjbUMtvFU Home@F12R-EQ5887L (RSA)
# 