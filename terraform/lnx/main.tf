provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "${var.ssh_public_key}"
}

module "host" {
  source      = "host"
  environment = "${var.environment}"

  instance_type           = "${var.instance_type}"
  cluster                 = "${aws_ecs_cluster.lnx.id}"
  vpc_id                  = "${module.network.vpc_id}"
  aws_ami                 = "${lookup(var.ecs_ami, var.region)}"
  ebs_a_snapshot_id       = "${lookup(var.bitcoind_snapshot, var.region)}"
  ebs_b_snapshot_id       = "${lookup(var.lnd_snapshot, var.region)}"
  iam_instance_profile_id = "${var.iam_instance_profile_id}"
  key_name                = "${aws_key_pair.ecs.key_name}"
  subnet_id               = "${module.network.public_subnet_ids[0]}"
  internet_gateway_id     = "${module.network.internet_gateway_id}"
  cloudwatch_prefix       = "${local.cloudwatch_prefix}"
  depends_id              = "${module.network.depends_id}"  # Required to ensure internet connectivity is available at boot time
}

module "network" {
  source               = "../modules/network"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnet_cidrs  = "${var.public_subnet_cidrs}"
  private_subnet_cidrs = "${var.private_subnet_cidrs}"
  availability_zones   = "${var.availability_zones}"
  depends_id           = ""
}

resource "aws_ecs_cluster" "lnx" {
  name = "${var.environment}"
}
