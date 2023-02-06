output "elb_target_group_arn" {
  value = aws_lb_target_group.lb_target_group.arn
}

output "elastic_load_balancer_dns_name" {
  value = aws_lb.vic_lb.dns_name
}

output "elastic_load_balancer_zone_id" {
  value = aws_lb.vic_lb.zone_id
}
