output "vpc_id" {
  value = "${module.network.vpc_id}"
}

output "ecs_instance_security_group_id" {
  value = "${module.ecs_instances.ecs_instance_security_group_id}"
}

output "vpc_public_subnet_ids" {
  value = "${module.network.public_subnet_ids}"
}

output "cluster_id" {
  value = "${aws_ecs_cluster.cluster.id}"
}

output "internet_gateway_id" {
  value = "${module.network.internet_gateway_id}"
}