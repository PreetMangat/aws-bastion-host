resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.vpc_cidr]
  }
}

resource "aws_launch_template" "bastion_host_launch_template" {
  image_id               = data.aws_ami.amazon_linux_ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = "ssh_bastion_hosts"
}

resource "aws_autoscaling_group" "bastion_host_autoscaling_group" {
  vpc_zone_identifier = var.private_bastion_subnet_ids
  target_group_arns   = [var.nlb_target_group_arn]
  health_check_type   = "ELB"
  min_size            = 3
  max_size            = 3
  launch_template {
    id      = aws_launch_template.bastion_host_launch_template.id
    version = "$Latest"
  }
}
