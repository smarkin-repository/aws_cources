resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = var.tags
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = var.tags
}

## Default route to Internet
resource "aws_route" "rt_default" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}
