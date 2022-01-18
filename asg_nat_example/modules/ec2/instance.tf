resource "aws_instance" "webserver" {
	count = length(var.subnets_id) 
	ami = var.ami_id
	instance_type = var.instance_type
	security_groups = var.sg_ids
	subnet_id = element(var.subnets_id, count.index)
	user_data = file(var.user_data)
    tags = var.tags
}