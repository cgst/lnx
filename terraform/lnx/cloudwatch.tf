resource "aws_cloudwatch_log_group" "dmesg" {
  name              = "${local.cloudwatch_prefix}/var/log/dmesg"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "docker" {
  name              = "${local.cloudwatch_prefix}/var/log/docker"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ecs-agent" {
  name              = "${local.cloudwatch_prefix}/var/log/ecs/ecs-agent.log"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ecs-init" {
  name              = "${local.cloudwatch_prefix}/var/log/ecs/ecs-init.log"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "audit" {
  name              = "${local.cloudwatch_prefix}/var/log/ecs/audit.log"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "messages" {
  name              = "${local.cloudwatch_prefix}/var/log/messages"
  retention_in_days = 30
}
