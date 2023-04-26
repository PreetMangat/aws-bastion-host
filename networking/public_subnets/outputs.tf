output "public_subnet_ids" {
  value = [for public_subnet in aws_subnet.public_subnets : public_subnet.id]
}
