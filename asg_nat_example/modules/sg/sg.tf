### SG for ALB

resource "aws_security_group" "default" {
    name = var.name
    description = var.description
    vpc_id = var.vpc_id
    tags = var.tags
}

resource "aws_security_group_rule" "ingress_80" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.allow_cidr_blocks
    security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "ingress_443" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = var.allow_cidr_blocks
    security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "egress" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.default.id
}