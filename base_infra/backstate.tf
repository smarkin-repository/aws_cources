terraform {
  backend "s3" {
    bucket = "omakaupunkitfstate"
    key = "oma/infra/base.tfstate"
    region = "eu-north-1"
    # profile = "main"
    dynamodb_table = "omakaupunki_db_terr_state_lock"
  }
}