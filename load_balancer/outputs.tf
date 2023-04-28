output "nlb_target_group_arn" {
  value = aws_lb_target_group.bastion_host_target_group.arn
}
