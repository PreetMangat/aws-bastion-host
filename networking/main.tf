resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/25" # 128 IP addresses
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Public subnets - for the load balancer
resource "aws_subnet" "public_subnet" {
  count                   = 3
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 3, count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ca-central-1${element(["a", "b", "d"], count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

# Private subnets - for the bastion host instances
resource "aws_subnet" "private_bastion_subnet" {
  count                   = 3
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 3, count.index + 3)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ca-central-1${element(["a", "b", "d"], count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_bastion_subnet_${count.index + 1}"
  }
}

# Private subnet - for the ec2 instance that the bastion hosts allow access to
resource "aws_subnet" "private_instance_subnet" {
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 3, 6)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_instance_subnet"
  }
}
