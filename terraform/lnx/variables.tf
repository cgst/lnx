variable "environment" {}
variable "region" {}
variable "ssh_public_key" {}
variable "iam_instance_profile_id" {}

variable "instance_type" {
  default = "m5a.large"
}

variable "ecs_ami" {
  type = "map"

  default = {
    "us-east-1"      = "ami-0bf2fb355727b7faf"
    "us-west-1"      = "ami-0c9bd36a7394439a6"
    "ap-southeast-1" = "ami-00ae2723e3c86c93e"
    "eu-central-1"   = "ami-0ce9ac8aed24e9ee5"
    "sa-east-1"      = "ami-0ec252e7e0588e54d"
  }
}

variable "bitcoind_snapshot" {
  type = "map"

  default = {
    "us-east-1"      = "snap-0ca6c5b445ac33986"
    "us-west-1"      = "snap-05f72c2715d43df0e"
    "ap-southeast-1" = "snap-04b123964bba32019"
    "eu-central-1"   = "snap-0c6dec8a1ca1abee1"
    "sa-east-1"      = "snap-0d7b82588c404798f"
  }
}

variable "lnd_snapshot" {
  type = "map"

  default = {
    "us-east-1"      = "snap-0a3dad16496e68a06" # Empty ext4
    "us-west-1"      = "snap-0bc81c2b0cdde7248" # Empty ext4
    "ap-southeast-1" = "snap-03e10c98dd326a6d1" # Empty ext4
    "eu-central-1"   = "snap-0d444401da1e7e2c0" # Empty ext4
    "sa-east-1"      = "snap-097c5a2873070fbc0" # Empty ext4
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type    = "list"
  default = ["10.0.50.0/24", "10.0.51.0/24"]
}

variable "public_subnet_cidrs" {
  type    = "list"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "availability_zones" {
  type = "list"
}

variable "ln_color" {
  default = "#FA7268"
}

variable "ln_banner" {}

variable "public_hostname" {}
