resource "aws_lb" "this" {
    name = var.lb_name
    subnets = var.public_subnet_ids
    security_groups = var.security_groups_lb
    tags = var.tags
}

resource "aws_lb_target_group" "this" {
    name = "${var.lb_name}-default"
    port = var.port
    protocol = var.protocol
    vpc_id = var.vpc_id
    deregistration_delay = var.deregistration_delay

    health_check = var.health_check
    tags = var.tags
}

resource "aws_lb_listener" "http" { 
    load_balancer_arn = aws_lb.this.id
    port = var.port
    protocol = var.protocol

    default_action {
        target_group_arn = aws_lb_target_group.this.id
        type             = "forward"
    }
}

# resource "aws_lb_target_group_attachment" "webserver" {
#     count = length(var.instances_id)
#     target_group_arn = aws_lb.this.arn
#     target_id        = element(var.instances_id,count.index)
#     port             = 80
# }
