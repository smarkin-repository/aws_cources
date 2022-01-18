output "default_id" {
    value = aws_security_group.default.id
}

output "ssh_proxy" {
    value = aws_security_group.ssh_proxy.id
}

output "icmp" {
    value = aws_security_group.icmp.id
}