# Private subnets - for the bastion host instances
resource "aws_subnet" "private_bastion_subnets" {
  count                   = 3
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 3, count.index + 3)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ca-central-1${element(["a", "b", "d"], count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_bastion_subnet_${count.index + 1}"
  }
}

resource "aws_network_acl" "private_subnet_nacl" {
  vpc_id = aws_vpc.vpc.id
  ingress { # Inbound (request) ssh traffic from the public subnet
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.vpc.cidr_block
    from_port  = 22
    to_port    = 22
  }
  egress { # Outbound (response) ssh traffic from the private subnet
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.vpc.cidr_block
    from_port  = 1024
    to_port    = 65535
  }
}

resource "aws_network_acl_association" "private_subnet_nacl_associations" {
  count          = 3
  network_acl_id = aws_network_acl.private_subnet_nacl.id
  subnet_id      = aws_subnet.private_bastion_subnets[count.index].id
}
