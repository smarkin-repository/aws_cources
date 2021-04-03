provider "aws" {
  version = "~> 3.0"
  region  = var.region
}

data "local_file" "install_httpd" {
    filename = "${path.module}/../scripts/install_httpd.sh"
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

# Generate a random name
resource "random_string" "random-name" {
  length  = 8
  upper   = false
  number  = true
  lower   = true
  special = false
}

module "vpc" {
    source = "./modules/vpc/"
    cidr_block = var.cidr_block
    destination_cidr_block = var.destination_cidr_block
    tags = {
        Name = "vpc-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "public_subnet" {
    source = "./modules/subnet"
    vpc_id = module.vpc.id
    name = "public"
    cidrs = var.public_cidr_block
    availability_zones = var.availability_zones
    tags = {
        Name = "${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
    # depends_on = [module.vpc]
}

module "private_subnet" {
    source = "./modules/subnet"
    name = "private"
    vpc_id = module.vpc.id
    cidrs = var.private_cidr_block
    availability_zones = var.availability_zones
    tags = {
        Name = "${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "database_subnet" {
    source = "./modules/subnet"
    name = "database"
    vpc_id = module.vpc.id
    cidrs = var.database_cidr_block
    availability_zones = var.availability_zones
    tags = {
        Name = "${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "sg" {
    source = "./modules/sg"
    name = "allow_tls_${var.name}"
    vpc_id = module.vpc.id
    allow_cidr_blocks = var.allow_cidr_blocks
    tags = {
        Name = "sg-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "nat_gw" {
    source = "./modules/nat_gw"
    subnet_ids = module.public_subnet.ids
}

module "network" {
    source = "./modules/network"
    vpc_id = module.vpc.id
    igw_id = module.vpc.igw_id
    nat_ids = module.nat_gw.nat_ids
    public_rt_ids = module.public_subnet.route_table_ids
    private_rt_ids = module.private_subnet.route_table_ids
    destination_cidr_block = var.destination_cidr_block
    tags = {
        Name = "rt-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "s3_logs" {
    source = "./modules/s3"
    name                  = "s3-${var.company}-lb-log"
    # logging_target_bucket = "s3-access-log"

    versioning_enabled = false
    force_destroy      = true

    region                                     = var.region
    lifecycle_rule_enabled                     = true
    lifecycle_rule_prefix                      = ""
    standard_ia_transition_days                = "60"
    glacier_transition_days                    = "90"
    expiration_days                            = "180"
    glacier_noncurrent_version_transition_days = "60"
    noncurrent_version_expiration_days         = "90"

    tags = {
        Name = "s3-lb-log-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
    
}

# module "bastion" {
#     source = "./modules/instance"
#     subnets_id = module.public_subnet.ids
#     ami_id = data.aws_ami.amazon_linux_2.id 
#     instance_type = var.instance_type
#     sg_ids = [module.sg.default_id, module.sg.ssh_proxy]
#     # nat_eip_ids = module.nat_gw.eip_ids
#     availability_zones = var.availability_zones
#     key_name = var.key_name
#     tags = {
#         Name = "bastion-${var.name}"
#         Environment = "${var.environment}"
#         Owner = "${var.owner}"
#         Company = "${var.company}"
#     }
#     user_data = file(data.local_file.install_httpd.filename)
# }

# module "elb" {
#     source = "./modules/elb"
#     vpc_id = module.vpc.id
#     name = "elb-${var.name}"
#     port = var.port
#     protocol = "HTTP"
#     # subnets = module.public _subnet.ids
#     subnets = module.private_subnet.ids
#     security_groups = [module.sg.default_id]
#     tg_port = var.port
#     lb_port = var.port
#     hc_target = var.hc_target
#     tags = {
#         Name = "elb-${var.name}"
#         Environment = "${var.environment}"
#         Owner = "${var.owner}"
#         Company = "${var.company}"
#     }
# }

module "lb" {
    source = "./modules/lb"
    vpc_id = module.vpc.id
    lb_name = "lb-${var.name}"
    port = var.port
    protocol = "HTTP"
    subnets = module.public_subnet.ids
    security_groups = [module.sg.default_id]
    s3_bucket_logs = module.s3_logs.bucket_id
    hc_path = "/"
    tags = {
        Name = "lb-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "asg" {
    source = "./modules/asg"
    name = "${var.name}-${var.environment}"
    ami_id = data.aws_ami.amazon_linux_2.id
    instance_type = var.instance_type
    subnet_ids = module.private_subnet.ids
    security_group_ids = [module.sg.default_id, module.sg.icmp, module.sg.ssh_proxy]
    availability_zones = var.availability_zones
    min_size = var.min_size 
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    # load_balancers = [module.elb.id]
    target_group_arns = [module.lb.target_group_arn]
    key_name = var.key_name
    associate_public_ip_address = false
    tags = {
        Name = "asg-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
    user_data = file(data.local_file.install_httpd.filename)
}

module "bastion-asg" {
    source = "./modules/asg"
    name = "bastion-${var.environment}"
    ami_id = data.aws_ami.amazon_linux_2.id
    instance_type = var.instance_type
    subnet_ids = module.public_subnet.ids
    security_group_ids = [module.sg.default_id, module.sg.icmp, module.sg.ssh_proxy]
    availability_zones = var.availability_zones
    min_size = 0 
    max_size = 1
    desired_capacity = 0
    # load_balancers = [module.elb.id]
    # lb_target_group_arn = module.lb.target_group_arn
    key_name = var.key_name
    associate_public_ip_address = true
    tags = {
        Name = "asg-bastion-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
    user_data = file(data.local_file.install_httpd.filename)
}

# module "r53_record" {
#     source = "./modules/r53"
#     zone_id = var.zone_id
#     dns_name = "${var.environment}.${var.dns_name}"
#     lb_dns_name = module.lb.dns_name
#     lb_main_zone_id = module.lb.zone_id
# }

