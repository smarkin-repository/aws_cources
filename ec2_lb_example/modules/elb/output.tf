output "arn" {
  value = "${aws_elb.this.arn}"
}

output "id" {
  value = "${aws_elb.this.id}"
}


output "dns_name" {
  value = "${aws_elb.this.dns_name}"
}

output "zone_id" {
  value = "${aws_elb.this.zone_id}"
}

