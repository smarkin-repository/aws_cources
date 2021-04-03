resource "aws_eip" "nat" {
    vpc = true
    count = length(var.subnet_ids)
}

resource "aws_nat_gateway" "nat" {
    allocation_id = element(aws_eip.nat.*.id, count.index)
    subnet_id = element(var.subnet_ids, count.index)
    count = length(var.subnet_ids)
}


# will use aws_eip_association late in the EC2 module
