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
    "us-east-1" = "ami-0bf2fb355727b7faf"
    "us-west-1" = "ami-082091011e69ea8a8"
  }
}

variable "bitcoind_snapshot" {
  type = "map"
  default = {
    "us-east-1" = "snap-0ca6c5b445ac33986"
    "us-west-1" = "snap-05f72c2715d43df0e"
  }
}

variable "lnd_snapshot" {
  type = "map"
  default = {
    "us-east-1" = "snap-0a3dad16496e68a06"  # Empty ext4
    "us-west-1" = "snap-0bc81c2b0cdde7248"  # Empty ext4
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type = "list"
  default = ["10.0.50.0/24", "10.0.51.0/24"]
}

variable "public_subnet_cidrs" {
  type = "list"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "availability_zones" {
  type = "list"
}

variable "ln_color" {
  default = "#FA7268"
}

variable "ln_banner" {}
