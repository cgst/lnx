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
  max_size                  = "0"
  desired_capacity          = "0"
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

module "host" {
  source = "host"
  environment = "${var.environment}"

  instance_type = "m5a.large"
  cluster = "${module.ecs.cluster_id}"
  vpc_id = "${module.ecs.vpc_id}"
  aws_ami = "${lookup(var.ecs_ami, var.region)}"
  ebs_a_snapshot_id = "${lookup(var.bitcoind_snapshot, var.region)}"
  ebs_b_snapshot_id = "${lookup(var.lnd_snapshot, var.region)}"
  iam_instance_profile_id = "${var.iam_instance_profile_id}"
  key_name = "${aws_key_pair.ecs.key_name}"
  subnet_id = "${module.ecs.vpc_public_subnet_ids[0]}"
  internet_gateway_id = "${module.ecs.internet_gateway_id}"
}
