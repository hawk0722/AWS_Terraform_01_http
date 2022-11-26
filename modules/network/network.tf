# VPC
resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.project}-${var.env}-vpc"
  }
}

# Subnet
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "${var.region}a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.env}-subnet-public-${var.region}a"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "${var.region}c"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.env}-subnet-public-${var.region}c"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "${var.region}a"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 11)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.env}-subnet-private-${var.region}a"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "${var.region}c"
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 12)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.env}-subnet-private-${var.region}c"
  }
}

# Route table for public
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.env}-rtb-public"
  }
}

resource "aws_route_table_association" "public_rtb_1a" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}

resource "aws_route_table_association" "public_rtb_1c" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public_subnet_1c.id
}

# Route table for private
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.env}-rtb-private"
  }
}

resource "aws_route_table_association" "private_rtb_1a" {
  route_table_id = aws_route_table.private_rtb.id
  subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_rtb_1c" {
  route_table_id = aws_route_table.private_rtb.id
  subnet_id      = aws_subnet.private_subnet_1c.id
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.env}-igw"
  }
}

resource "aws_route" "public_rtb_igw" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


# Security groups
resource "aws_security_group" "web" {
  name   = "${var.project}-${var.env}-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "allow http"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.env}-sg"
  }
}
