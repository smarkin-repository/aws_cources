resource "aws_instance" "webserver" {
	count = length(var.subnets_id) 
	ami = var.ami_id
	instance_type = var.instance_type
	security_groups = var.sg_ids
	subnet_id = element(var.subnets_id, count.index)
	availability_zone = element(var.availability_zones, count.index)
	key_name = var.key_name
	associate_public_ip_address = true
	user_data = var.user_data
    tags = var.tags
}

