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
    }

    variable "nat_eip_ids" {
        type = list
    }
