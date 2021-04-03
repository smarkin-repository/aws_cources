provider "aws" {
  version = "~> 3.0"
  region  = var.region
}


data "local_file" "install_httpd" {
    filename = "${path.module}/scripts/install_httpd.sh"
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

#   filter {
#     name   = "architecture"
#        values = ["x86_64"]
#   }

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
    name = "public_net"
    cidrs = var.public_cidr_block
    availability_zones = var.availability_zones
    tags = {
        Name = "public_subnet-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
    # depends_on = [module.vpc]
}

module "private_subnet" {
    source = "./modules/subnet"
    name = "private_net"
    vpc_id = module.vpc.id
    cidrs = var.private_cidr_block
    availability_zones = var.availability_zones
    tags = {
        Name = "private_subnet-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "sg_default" {
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

module "route" {
    source = "./modules/route"
    vpc_id = module.vpc.id
    igw_id = module.vpc.igw_id
    nat_ids = module.nat_gw.ids
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

# module "instance" {
#     source = "./modules/instance"
#     subnets_id = module.private_subnet.ids
#     ami_id = data.aws_ami.ubuntu.id
#     instance_type = var.instance_type
#     sg_ids = [module.sg_default.id]
#     nat_eip_ids = module.nat_gw.eip_ids
#     tags = {
#         Name = "ec2-${var.name}"
#         Environment = "${var.environment}"
#         Owner = "${var.owner}"
#         Company = "${var.company}"
#     } 
#     user_data = data.local_file.install_httpd.filename
# }

module "lb" {
    source = "./modules/lb"
    vpc_id = module.vpc.id
    lb_name = "lb-${var.name}"
    port = 80
    protocol = "HTTP"
    hc_target = "HTTP:80/index.html"
    public_subnet_ids = module.public_subnet.ids
    security_groups_lb = [module.sg_default.id]
    tags = {
        Name = "lb-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
}

module "asg" {
    source = "./modules/asg"
    vpc_id = module.vpc.id
    # private_subnets_id = module.private_subnet.ids
    subnets_id = module.public_subnet.ids
    aws_ami = data.aws_ami.amazon_linux_2.id
    instance_type = var.instance_type
    lb_target_group_arn = module.lb.target_group
    name = "host-asg"
    tags = {
        Name = "ec2-${var.name}"
        Environment = "${var.environment}"
        Owner = "${var.owner}"
        Company = "${var.company}"
    }
    user_data = data.local_file.install_httpd.filename
}