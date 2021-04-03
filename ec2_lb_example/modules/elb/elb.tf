# Create a new load balancer
resource "aws_elb" "this" {
  name = var.name
  subnets = var.subnets  
  security_groups = var.security_groups
  internal        = false

  listener {
    instance_port     = var.port
    instance_protocol = "http"
    lb_port           = var.port
    lb_protocol       = "http"
  }

  listener {
    instance_port     = var.port
    instance_protocol = "tcp"
    lb_port           = var.port
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = var.port
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = var.hc_target
    interval            = 30
  }

  # instances                   = var.instance_ids
  # cross_zone_load_balancing   = true
  # idle_timeout                = 100
  # connection_draining         = true
  # connection_draining_timeout = 300

  tags = var.tags
}


resource "aws_elb_attachment" "this" {
  count = length(var.instances)

  elb      = aws_elb.this.id
  instance = element(var.instances, count.index)
}