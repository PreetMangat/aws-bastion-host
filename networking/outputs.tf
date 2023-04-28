output "public_subnet_ids" {
  value = [for public_subnet in aws_subnet.public_subnets : public_subnet.id]
}

output "private_bastion_subnet_ids" {
  value = [for private_bastion_subnet in aws_subnet.private_bastion_subnets : private_bastion_subnet.id]
}

output "public_subnet_cidrs" {
  value = [for public_subnet in aws_subnet.public_subnets : public_subnet.cidr_block]
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
