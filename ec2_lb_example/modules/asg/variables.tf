variable "max_size" {
    type = string
    default = "1"
}

variable "min_size" {
    type = string
    default = "1"
}

variable "desired_capacity" {
    type = string
    default = "1"
}

variable "subnet_ids" {
    type = list
}

variable "elastic_load_balancers" {
    type = list
    default = []
}

variable "load_balancers" {
    type = list
    default = []
    description = "The load balancers to couple to the instances. Only used when NOT using ALB"
}

variable "ami_id" {
    type = string
    description = "(optional) describe your variable"
}

variable "instance_type" {
    type = string
    description = "(optional) describe your variable"
}

variable "user_data" {
    type = string
    description = "(optional) describe your variable"
    default = ""
}

variable "tags" {
    type = map
    description = "(optional) describe your variable"
}

# variable "vpc_id" {
#     type = string
#     description = "(optional) describe your variable"
# }

variable "name" {
    type = string
    description = "(optional) describe your variable"
}

variable "target_group_arns" {
    type = list
    default = []
}

variable "lb_target_group_arn" {
    type = string
    description = "(optional) describe your variable"
    default = ""
}

variable "security_group_ids" {
    type = list
    default = []
}

variable "availability_zones" {
    type = list
    default = []
}

variable "associate_public_ip_address" {
    type = bool
    default = true
}

variable "key_name" {
    type = string
    default = ""
}