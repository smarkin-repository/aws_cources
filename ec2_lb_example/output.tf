output "vpc_id" {
    value = module.vpc.id
}

output "public_ips" {
  value = module.nat_gw.eip_public_ips
}


output "public_subnet_ids" {
  value = module.public_subnet.ids
}

output "public_route_table_ids" {
  value = module.public_subnet.route_table_ids
}

output "private_subnet_ids" {
  value = module.private_subnet.ids
}

output "private_route_table_ids" {
  value = module.private_subnet.route_table_ids
}

output "database_subnet_ids" {
  value = module.database_subnet.ids
}

output "database_route_table_ids" {
  value = module.database_subnet.route_table_ids
}

output "nat_gw_ids" {
  value = module.nat_gw.nat_ids
}

output "sg_default_id" {
    value = module.sg.default_id
}

output "lb_tg_arn" {
    value = module.lb.target_group_arn
}

output "lb_dns_name" {
    value = module.lb.dns_name
}

output "asg_arn" {
    value = module.asg.arn
}

output "asg_id" {
    value = module.asg.id
}

# output "r53_record" {
#     value = module.r53_record.dns_name
# }

# output "instance_ids" {
#     value = module.instance.ids
# }

