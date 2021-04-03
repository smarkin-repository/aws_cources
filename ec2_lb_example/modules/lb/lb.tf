# data "aws_acm_certificate" "cert" {
#     domain = "taloni.club"
# }

data "aws_route53_zone" "public" {
  name         = "taloni.club"
  private_zone = false
#   provider     = aws.account_route53
}



# This creates an SSL certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = "*.taloni.club"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id  = data.aws_route53_zone.public.id
  ttl      = 60
#   provider = aws.account_route53
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [ aws_route53_record.cert_validation.fqdn ]
}


# resource "aws_acm_certificate" "cert" {
#   domain_name = "*.taloni.club"
#   validation_method = "DNS"

#   tags= {
#       Environment = "dev"
#       Owner = "smarkin"
#       Name = "taloni"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_lb" "this" {
    name = var.lb_name
    subnets = var.subnets
    security_groups = var.security_groups
    load_balancer_type = "application"

    access_logs {    
        bucket = var.s3_bucket_logs
        prefix = "LB-logs"
        enabled = true
    }

    tags = var.tags
}

resource "aws_lb_target_group" "this" {
    name = "${var.lb_name}-lb"
    port = var.port
    protocol = var.protocol
    vpc_id = var.vpc_id
    deregistration_delay = var.deregistration_delay

    health_check {
        path                = var.hc_path
        port                = 80
        interval            = 30
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
    }
    tags = var.tags
}

resource "aws_lb_target_group" "this_443" {
    name = "${var.lb_name}-lb-443"
    port = 443
    protocol = var.protocol
    vpc_id = var.vpc_id
    deregistration_delay = var.deregistration_delay

    health_check {
        path                = var.hc_path
        port                = 443
        interval            = 30
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
    }
    tags = var.tags
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.this.arn
    port = var.port
    protocol = var.protocol 

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.this.arn
    }
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.this.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = aws_acm_certificate.cert.arn
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.this_443.arn
    }
}

resource "aws_lb_target_group_attachment" "instances_80" {
    count = length(var.instance_ids)
    target_group_arn = aws_lb.this.arn
    target_id        = element(var.instance_ids,count.index)
    port             = var.port
}

resource "aws_lb_target_group_attachment" "instances_443" {
    count = length(var.instance_ids)
    target_group_arn = aws_lb.this.arn
    target_id        = element(var.instance_ids,count.index)
    port             = 443
}

# Standard route53 DNS record for "myapp" pointing to an ALB
resource "aws_route53_record" "srv" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "dev.${data.aws_route53_zone.public.name}"
  type    = "A"
  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = false
  }
#   provider = aws.account_route53
}

# resource "aws_lb_listener_certificate" "cert" {
#   listener_arn    = aws_lb_listener.https.arn
#   certificate_arn = aws_acm_certificate.cert.arn
# }


output "testing" {
  value = "Test this demo code by going to https://${aws_route53_record.srv.fqdn} and checking your have a valid SSL cert"
}
