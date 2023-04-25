# Private subnets - for the bastion host instances
resource "aws_subnet" "private_bastion_subnets" {
  count                   = 3
  cidr_block              = cidrsubnet(var.vpc_cidr, 3, count.index + 3)
  vpc_id                  = var.vpc_id
  availability_zone       = "ca-central-1${element(["a", "b", "d"], count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_bastion_subnet_${count.index + 1}"
  }
}

# Private subnet - for the ec2 instance that the bastion hosts allow access to
resource "aws_subnet" "private_instance_subnet" {
  cidr_block              = cidrsubnet(var.vpc_cidr, 3, 6)
  vpc_id                  = var.vpc_id
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_instance_subnet"
  }
}
