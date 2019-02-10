provider "aws" {
  region = "${var.region}"
}

module "ecs" {
  source = "../modules/ecs"

  environment               = "${var.environment}"
  cluster                   = "${var.environment}"
  cloudwatch_prefix         = "${var.environment}"
  vpc_cidr                  = "${var.vpc_cidr}"
  public_subnet_cidrs       = "${var.public_subnet_cidrs}"
  private_subnet_cidrs      = "${var.private_subnet_cidrs}"
  availability_zones        = "${var.availability_zones}"
  min_size                  = "0"
  max_size                  = "1"
  desired_capacity          = "1"
  key_name                  = "${aws_key_pair.ecs.key_name}"
  instance_type             = "${var.instance_type}"
  ecs_aws_ami               = "${lookup(var.ecs_ami, var.region)}"
  iam_instance_profile_id   = "${var.iam_instance_profile_id}"
  ebs_snapshot_id           = "${lookup(var.bitcoind_snapshot, var.region)}"
  custom_userdata           = ""
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "${var.ssh_public_key}"
}
