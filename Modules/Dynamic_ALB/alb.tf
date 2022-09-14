resource "aws_lb" "lb" {
  count                            = length(var.ALB_Name)
  name                             = var.ALB_Name[count.index]
  internal                         = var.internal
  load_balancer_type               = "application"
  subnets                          = var.subnet
  security_groups                  = var.sg_id
  enable_deletion_protection       = var.enable_deletion_protection_state
  drop_invalid_header_fields       = var.drop_invalid_header_fields_state
  preserve_host_header             = var.preserve_host_header_state
  idle_timeout                     = var.idle_timeout_value
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing_state
  enable_http2                     = var.enable_http2_state
  enable_waf_fail_open             = var.enable_waf_fail_open_state
  ip_address_type                  = var.ip_add_type
}

locals {
  load-balancers-arn = tolist(aws_lb.lb.*.arn)

}

resource "aws_lb_target_group" "tg" {
  count                  = length(var.Target_Group_Name)
  name                   = var.Target_Group_Name[count.index]
  connection_termination = var.connection_termination_state
  port                   = var.port
  protocol               = var.protocol
  target_type            = var.target_type
  vpc_id                 = var.tg_vpc

  health_check {
    path     = var.health_check_path
    port     = var.health_check_port
    protocol = var.health_check_protocol
    timeout  = var.health_check_timeout
    interval = var.health_check_interval
  }
}

locals {
  target-groups-arn = tolist(aws_lb_target_group.tg.*.arn)

}


resource "aws_lb_target_group_attachment" "lb_tg_att" {
  count            = length(var.Target_ids) * length(local.target-groups-arn)
  target_group_arn = local.target-groups-arn[floor(count.index / length(var.Target_ids))]
  target_id        = var.Target_ids[count.index % length(var.Target_ids)]
  port             = var.port
}



resource "aws_lb_listener" "lb_list" {
  count             = length(local.load-balancers-arn)
  load_balancer_arn = local.load-balancers-arn[count.index]
  port              = var.port
  protocol          = var.protocol
  alpn_policy       = var.alpn_policy
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = local.target-groups-arn[count.index]
  }
}

