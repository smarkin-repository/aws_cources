output "id" {
    value = "${aws_vpc.vpc.id}"
}

output "cidr_block" {
    value = "${aws_vpc.vpc.cidr_block}"
}

output "igw_id" {
    value = "${aws_internet_gateway.igw.id}"
}

output "rt_default_id" {
    value = aws_route.rt_default.id
}