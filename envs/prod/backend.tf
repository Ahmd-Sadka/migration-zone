terraform {
  backend "s3" {
    bucket         = "state-zone"
    key            = "prod/backend.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "earthzone-terraform-locks"
  }
}