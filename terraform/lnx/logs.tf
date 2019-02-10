resource "aws_cloudwatch_log_group" "lnx" {
  name = "${var.environment}"

  tags = {
    Environment = "${var.environment}"
  }
}