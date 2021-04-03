provider "aws" {
    version          = "2.70"
    region           = var.aws_region
}

resource "aws_s3_bucket" "tfbucket" {
  bucket = "${var.company}tfstate"
  region = var.aws_region

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
}

resource "aws_dynamodb_table" "db_terraform_state_lock" {
    name = "${var.company}_db_terr_state_lock"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20
    
    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name = "Main terraform state lock"
        Owner = var.owner
        Environment = var.environment

    }
}