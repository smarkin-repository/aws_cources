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

variable "subnets_id" {
    type = list
}

variable "load_balancers" {
    type = list
    default = []
    description = "The load balancers to couple to the instances. Only used when NOT using ALB"
}

variable "aws_ami" {
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
}

variable "tags" {
    type = map
    description = "(optional) describe your variable"
}

variable "vpc_id" {
    type = string
    description = "(optional) describe your variable"
}

variable "name" {
    type = string
    description = "(optional) describe your variable"
}

variable "lb_target_group_arn" {
    type = string
    description = "(optional) describe your variable"
}