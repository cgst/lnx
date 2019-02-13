resource "aws_security_group" "host" {
  name        = "${var.environment}-host"
  description = "Used in ${var.environment}"
  vpc_id      = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "inbound_lnd_access_from_world" {
  security_group_id = "${aws_security_group.host.id}"
  type              = "ingress"
  from_port         = 9735
  to_port           = 9735
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "lnd peer connections"
}
