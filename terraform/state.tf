terraform {
  backend "s3" {
    bucket = "lnx-tf"
    key    = "lnx.tfstate"
    region = "us-west-1"
  }
}

