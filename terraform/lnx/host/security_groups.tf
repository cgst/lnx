resource "aws_security_group" "host" {
  name        = "${var.environment}-host"
  description = "Used in ${var.environment}"
  vpc_id      = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Environment = "${var.environment}"
    Name        = "${format("%s-host", var.environment)}"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
