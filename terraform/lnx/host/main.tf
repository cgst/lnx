resource "aws_instance" "host" {
  ami = "${var.aws_ami}"
  source_dest_check = false
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.host.id}"]
  monitoring = true
  user_data = "${data.template_file.user_data.rendered}"
  disable_api_termination = false
  iam_instance_profile = "${var.iam_instance_profile_id}"

  ebs_block_device {
    # Docker volume spec needs to match AWS ECS optimized AMI spec
    device_name = "/dev/xvdcz"
    volume_type = "gp2"
    volume_size = 22
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/sdm"
    snapshot_id = "${var.ebs_a_snapshot_id}"
    delete_on_termination = false
    volume_type = "gp2"
  }

  ebs_block_device {
    device_name = "/dev/sdn"
    snapshot_id = "${var.ebs_b_snapshot_id}"
    delete_on_termination = false
    volume_type = "gp2"
  }

  tags {
    Name = "${var.environment}-host"
    Environment = "${var.environment}"
    # EC2 instances require internet connectivity to boot. Thus EC2 instances must not start before NAT is available.
    # For info why see description in the network module.
    DependsId = "${var.depends_id}"
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

resource "aws_eip" "host" {
  vpc = true
  tags {
    DependsId = "${var.internet_gateway_id}"
  }
}

resource "aws_eip_association" "host" {
  instance_id = "${aws_instance.host.id}"
  allocation_id = "${aws_eip.host.id}"
  depends_on = [
    "aws_instance.host"]
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"

  vars {
    ecs_config = "${var.ecs_config}"
    ecs_logging = "${var.ecs_logging}"
    cluster_name = "${var.cluster_name}"
    env_name = "${var.environment}"
    custom_userdata = <<EOF
        mkdir /data-{bitcoind,lnd}
        mount /dev/sdm /data-bitcoind
        mount /dev/sdn /data-lnd
EOF
    cloudwatch_prefix = "${var.cloudwatch_prefix}"
  }
}
