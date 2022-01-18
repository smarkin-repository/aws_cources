output "ids" { 
    value = aws_nat_gateway.nat.*.id
}

output "eip_ids" {
    value = aws_eip.nat.*.id
}

output "eip_public_ips" {
    value = aws_eip.nat.*.public_ip
}