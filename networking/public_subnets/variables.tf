variable "vpc_id" {
  description = "ID of the VPC that the subnets will be in"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of the VPC that the subnets will be in"
  type        = string
}

variable "igw_id" {
  description = "ID of the IGW that the subnets route tables will use"
  type        = string
}
