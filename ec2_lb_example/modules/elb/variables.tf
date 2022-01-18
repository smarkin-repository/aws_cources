variable "name" {
    type = string
    default = "host"
}

variable "description" {
    type = string
    default = "loadbalancer on public network" 
}

variable "vpc_id" {
    type = string 
}

variable "public_subnet_ids" {
    type = list
    default = [] 
}

variable "port" {
    type = string 
    default = 80
}

variable "protocol" {
    type = string
    default = "HTTP"
}

variable "deregistration_delay" {
  default     = "300"
  description = "The default deregistration delay"
}

variable "security_groups" {
    type = list
    default = []
}

variable "tags" {
    type = map
    default = {}
}

variable "instances" {
    type = list
    default = []
}

variable "hc_target" {
    type = string
}

variable "subnets" {
    type = list
    description = "(optional) describe your variable"
}

variable "lb_port" {
    type = string
    description = ""
    default = 80
}

variable "tg_port" {
    type = string
    description = ""
    default = 80
}