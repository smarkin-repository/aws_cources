    variable "ami_id" {
        type = string
    }

	variable "instance_type" {
        type = string
    }

	variable  "sg_ids" {
        type = list
    }

	variable "subnets_id" {
        type = list
    }

    variable "tags"  {
        type = map
    } 

    variable "user_data" {
        type = string
        default = ""
    }

    variable "key_name" {
        type = string
        description = "(optional) describe your variable"
    }


    variable "nat_eip_ids" {
        type = list
        defaulr = []
    }

    variable "availability_zones" {
        type = list
        description = "(optional) describe your variable"
    }