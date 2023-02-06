 #route53 zone
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "vic_r53" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "terraform-test.${var.domain_name}"
  type    = "A"

alias {
    name                   = aws_lb.vic_lb.dns_name
    zone_id                = aws_lb.vic_lb.zone_id
    evaluate_target_health = true
  }
}
