resource "aws_lb" "network_load_balancer" {
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "bastion_host_target_group" {
  port     = 22
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "ssh_listener" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = "22"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bastion_host_target_group.arn
  }
}
