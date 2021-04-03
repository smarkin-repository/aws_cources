output "ids" {
  value = "${aws_subnet.this.*.id}"
}

output "route_table_ids" {
#   value = aws_route_table.this.id
  value = "${aws_route_table.this.*.id}"
}