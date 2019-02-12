resource "aws_route53_zone" "domain" {
  name = "${var.public_domain}."
}
