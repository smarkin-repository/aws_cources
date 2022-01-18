output "vpn_public_ip" {
  value = digitalocean_droplet.ec.ipv4_address
}