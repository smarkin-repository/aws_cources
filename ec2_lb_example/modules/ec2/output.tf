output "ids" {
    value = aws_instance.webserver.*.id
}

