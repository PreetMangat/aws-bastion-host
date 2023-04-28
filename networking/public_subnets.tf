resource "aws_subnet" "public_subnets" {
  count                   = 3
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 3, count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ca-central-1${element(["a", "b", "d"], count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_route_table_associations" {
  count          = 3
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

resource "aws_network_acl" "public_subnet_nacl" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    protocol   = "tcp"
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  egress {
    protocol   = "tcp"
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
}

resource "aws_network_acl_association" "public_subnet_nacl_associations" {
  count          = 3
  network_acl_id = aws_network_acl.public_subnet_nacl.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}
