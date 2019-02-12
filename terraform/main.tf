provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west"
  region = "us-west-1"
}

module "us-east" {
  source = "lnx"
  region = "us-east-1"
  ln_banner = "@cgst-US-East"
  availability_zones = ["us-east-1a", "us-east-1b"]
  environment = "${var.environment}"
  ssh_public_key = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
}

//module "us-west" {
//  source = "lnx"
//  region = "us-west-1"
//  availability_zones = ["us-west-1a", "us-west-1c"]
//  providers = {
//    aws = "aws.us-west"
//  }
//  environment = "${var.environment}"
//  ssh_public_key = "${var.ssh_public_key}"
//  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
//}

variable "environment" {}
variable "ssh_public_key" {}
