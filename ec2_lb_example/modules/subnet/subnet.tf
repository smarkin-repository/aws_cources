resource "aws_subnet" "this" {
    vpc_id = var.vpc_id
    cidr_block = element(var.cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)
    count = length(var.cidrs)

    tags = {
        Name = "subnet-${var.name}_${element(var.availability_zones, count.index)}"
        Environment = var.tags.Environment
        Owner = var.tags.Owner
    }
}

resource "aws_route_table" "this" {
    vpc_id = var.vpc_id
    count = length(var.cidrs)

    tags = {
        Name = "rt-${var.name}_${element(var.availability_zones, count.index)}"
        Environment = var.tags.Environment
        Owner = var.tags.Owner
    }
}

resource "aws_route_table_association" "subnet" {
    subnet_id = element(aws_subnet.this.*.id, count.index)
    route_table_id = element(aws_route_table.this.*.id, count.index)
    count = length(var.cidrs)
}
