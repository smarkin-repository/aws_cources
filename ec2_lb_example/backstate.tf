terraform {
  backend "s3" {
    bucket = "omakaupunkitfstate"
    key = "oma/host_infra_base/base-4.tfstate"
    region = "eu-north-1"
    # profile = "main"
    dynamodb_table = "omakaupunki_db_terr_state_lock"
  }
}