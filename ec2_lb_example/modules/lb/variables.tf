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

variable "subnets" {
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

variable "hc_path" {
    type = string
    default = "/"
}

variable "hc_port" {
    type = string
    default = "/"
}


variable "load_balancer_type" {
    type = string
    default = "application"
}

variable "instance_ids" {
    type = list
    default = []
}

variable "s3_bucket_logs" {
    type = string
    default = ""
}