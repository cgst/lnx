locals {
  # Strip subdomain part.
  hostname_parts = ["${split(".", var.public_hostname)}"]
  base_hostname  = "${join(".", slice(local.hostname_parts, 1, length(local.hostname_parts)))}"
}

data "aws_route53_zone" "selected" {
  name = "${local.base_hostname}."
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.public_hostname}."
  type    = "A"
  ttl     = "300"
  records = ["${module.host.host_external_ip}"]
}
