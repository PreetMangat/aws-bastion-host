variable "private_bastion_subnet_ids" {
  description = "List of subnet ids to launch bastion host instances into"
  type        = list(string)
}

variable "nlb_target_group_arn" {
  description = "arn of the target group the load balancer uses"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC that the target groups will use"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of the VPC"
  type        = string
}
