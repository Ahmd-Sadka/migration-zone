terraform {
  backend "s3" {
    bucket         = "state-zone"
    # dynamodb_table = "lockzone"
    key            = "preprod/backend.tfstate"
    region         = "us-east-1"

  }
}