module "bastion" {
  source          = "github.com/segmentio/stack/bastion"
  region          = "${var.region}"
  security_groups = "${aws_security_group.bastion.id}"
  vpc_id          = "${module.network.vpc_id}"
  key_name        = "${aws_key_pair.ecs.key_name}"
  subnet_id       = "${module.network.public_subnet_ids[0]}"
  environment     = "${var.environment}"
}

# Bastion security group allows SSH access from anywhere.
resource "aws_security_group" "bastion" {
  name   = "${format("%s-bastion", var.environment)}"
  vpc_id = "${module.network.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${format("%s-bastion", var.environment)}"
    Environment = "${var.environment}"
  }
}

# Allow SSH access to lnx host from bastion.
resource "aws_security_group_rule" "inbound_ssh_access_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion.id}"
  security_group_id        = "${module.host.host_security_group_id}"
}
