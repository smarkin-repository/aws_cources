variable "lb_name" {
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

variable "health_check_path" {
  default     = "/"
  description = "The default health check path"
}

variable "security_groups_lb" {
    type = list
    default = []
}

variable "tags" {
    type = map
    default = {}
}

variable "hc_target" {
    type = string
    default = "HTTP:80/index.html"
}

# variable "instances_id" {
#     type = list
# }