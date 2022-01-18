output "vpc_id" {
    value = module.vpc.id
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

output "nat_gw_ids" {
  value = module.nat_gw.ids
}

output "sg_default_id" {
    value = module.sg_default.id
}

output "lb_arn" {
    value = module.lb.target_group
}

output "lb_dns_name" {
    value = module.lb.dns_name
}

# output "instance_id" {
#     value = module.instance.ids
# }

