resource "aws_ecs_task_definition" "lnx" {
  family = "lnx"

  container_definitions = <<EOF
[
  {
    "name": "bitcoind",
    "image": "kylemanna/bitcoind",
    "memoryReservation": 2048,
    "essential": true,
    "command": ["btc_oneshot", "-datadir=/bitcoind-data", "-txindex=1", "-rpcbind", "-rpcallowip=0.0.0.0/0", "-conf=/bitcoin/.bitcoin/bitcoin.conf"],
    "environment": [
      {"name": "RPCUSER", "value": "OKToExposeRPCUser"},
      {"name": "RPCPASSWORD", "value": "OKToExposeRPCPassword"}
    ],
    "mountPoints": [
      {
        "sourceVolume": "bitcoind-data",
        "containerPath": "/bitcoind-data"
      }
    ],
    "portMappings": [
        {
            "containerPort": 8332,
            "hostPort": 8332,
            "protocol": "tcp"
        }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.region}",
        "awslogs-group": "${aws_cloudwatch_log_group.lnx.name}",
        "awslogs-stream-prefix": "bitcoind"
      }
    }
  }
]
EOF

  volume {
    name      = "bitcoind-data"
    host_path = "/data/bitcoind"
  }
}

data "aws_ecs_task_definition" "lnx" {
  task_definition = "${aws_ecs_task_definition.lnx.family}"
  depends_on = ["aws_ecs_task_definition.lnx"]
}

resource "aws_ecs_service" "lnx" {
  name            = "lnx"
  cluster         = "${module.ecs.cluster_id}"
  # Reference the latest task definition.
  task_definition = "${aws_ecs_task_definition.lnx.family}:${max("${aws_ecs_task_definition.lnx.revision}", "${data.aws_ecs_task_definition.lnx.revision}")}"
  desired_count   = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
