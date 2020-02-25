provider "aws" {
  version                 = "~> 2.47.0"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
  region                  = var.default_region
}

terraform {
  backend "s3" {
    bucket = "senshin-tfstate"
    key    = "docker-handson"
    region = "ap-northeast-1"
  }
}
