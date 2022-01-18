output "arn" {
  value = "${aws_lb.this.arn}"
}

output "dns_name" {
  value = "${aws_lb.this.dns_name}"
}

output "target_group_arn" {
  value = "${aws_lb_target_group.this.arn}"
}

output "zone_id" {
  value = "${aws_lb.this.zone_id}"
}