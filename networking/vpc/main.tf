resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/25" # 128 IP addresses
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}
