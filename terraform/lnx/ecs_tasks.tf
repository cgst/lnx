resource "aws_ecs_task_definition" "lnx" {
  family = "lnx"

  container_definitions = "${data.template_file.lnx_container_definitions.rendered}"

  volume {
    name      = "data-bitcoind"
    host_path = "/data-bitcoind/bitcoind"
  }

  volume {
    name      = "data-lnd"
    host_path = "/data-lnd"
  }
}

data "aws_ecs_task_definition" "lnx" {
  task_definition = "${aws_ecs_task_definition.lnx.family}"
  depends_on = ["aws_ecs_task_definition.lnx"]
}

resource "aws_ecs_service" "lnx" {
  name            = "lnx"
  cluster         = "${aws_ecs_cluster.lnx.id}"
  # Reference the latest task definition.
  task_definition = "${aws_ecs_task_definition.lnx.family}:${max("${aws_ecs_task_definition.lnx.revision}", "${data.aws_ecs_task_definition.lnx.revision}")}"
  desired_count   = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}

data "template_file" "lnx_container_definitions" {
  template = "${file("${path.module}/templates/lnx_container_definitions.json")}"

  vars {
    awslogs_region    = "${var.region}"
    awslogs_group     = "${aws_cloudwatch_log_group.lnx.name}"
    ln_banner         = "${var.ln_banner}"
    ln_color          = "${var.ln_color}"
  }
}
