output "aws_route_igw_ids" {
    value = aws_route.igw_route.*.id
}

output "aws_route_nat_ids" {
    value = aws_route.nat_route.*.id
}