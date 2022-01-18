# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.name
    Company = var.company
    Owner = var.owner
    Environment = var.environment
  }

}