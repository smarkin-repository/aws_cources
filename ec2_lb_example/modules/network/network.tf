resource "aws_route" "igw_route" {
  count                  = length(var.public_rt_ids)
  route_table_id         = element(var.public_rt_ids, count.index)
  gateway_id             = var.igw_id
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_route" "nat_route" {
  count                  = length(var.private_rt_ids)
  route_table_id         = element(var.private_rt_ids, count.index)
  nat_gateway_id         = element(var.nat_ids, count.index)
  destination_cidr_block = var.destination_cidr_block
}