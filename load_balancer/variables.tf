variable "public_subnet_ids" {
  description = "List of subnet ids to launch NLB listeners into"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC that the target groups will use"
  type        = string
}
