output "host_security_group_id" {
  value = "${aws_security_group.host.id}"
}

output "host_external_ip" {
  value = "${aws_eip.host.public_ip}"
}
