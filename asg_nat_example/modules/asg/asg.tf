# We separate the rules from the aws_security_group because then we can manipulate the 
# aws_security_group outside of this module
resource "aws_security_group" "instance" {
  name        = "${var.name}-${var.tags.Company}-for-asg-${var.tags.Environment}"
  description = "Used in ${var.tags.Environment}"
  vpc_id      = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "outbound_internet_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.instance.id}"
}

# Default disk size for Docker is 22 gig, see http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
resource "aws_launch_configuration" "launch" {
  name_prefix          = "${var.name}-${var.tags.Environment}"
  image_id             = var.aws_ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.instance.id]
  user_data            = file(var.user_data)
#   iam_instance_profile = "${var.iam_instance_profile_id}" 
#   key_name             = "${var.key_name}"

  # aws_launch_configuration can not be modified.
  # Therefore we use create_before_destroy so that a new modified aws_launch_configuration can be created 
  # before the old one get's destroyed. That's why we use name_prefix instead of name.
  lifecycle {
    create_before_destroy = true
  }
}

# Instances are scaled across availability zones http://docs.aws.amazon.com/autoscaling/latest/userguide/auto-scaling-benefits.html 
resource "aws_autoscaling_group" "asg" {
  name                 = "${var.name}-${var.tags.Name}-${var.tags.Environment}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.launch.id}"
  vpc_zone_identifier  = var.subnets_id
  load_balancers       = var.load_balancers

  tag {
    key                 = "Name"
    value               = "${var.tags.Name}"
    propagate_at_launch = "true"
  }

  tag {
    key                 = "Environment"
    value               = "${var.tags.Environment}"
    propagate_at_launch = "true"
  }

}

#Autoscaling Attachment
resource "aws_autoscaling_attachment" "svc_asg_external" {
  alb_target_group_arn   = "${var.lb_target_group_arn}"
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
}