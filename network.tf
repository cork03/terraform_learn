# --------------
# vpc
# --------------
resource "aws_vpc" "vpc" {
  cidr_block                       = "192.168.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    "Name"    = "${var.project}-${var.enviroment}"
    "Project" = var.project
    "Env"     = var.enviroment
  }
}

# --------------
# subnet
# --------------
resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    "Name"    = "${var.project}-${var.enviroment}-public-subnet-1a"
    "Project" = var.project
    "Env"     = var.enviroment
    "Type"    = "public"
  }
}

resource "aws_subnet" "public-subnet-1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    "Name"    = "${var.project}-${var.enviroment}-public-subnet-1c"
    "Project" = var.project
    "Env"     = var.enviroment
    "Type"    = "public"
  }
}

resource "aws_subnet" "private-subnet-1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    "Name"    = "${var.project}-${var.enviroment}-private-subnet-1a"
    "Project" = var.project
    "Env"     = var.enviroment
    "Type"    = "private"
  }
}

resource "aws_subnet" "private-subnet-1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.4.0/24"
  map_public_ip_on_launch = false

  tags = {
    "Name"    = "${var.project}-${var.enviroment}-private-subnet-1c"
    "Project" = var.project
    "Env"     = var.enviroment
    "Type"    = "private"
  }
}

# --------------
# route-table
# --------------

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name"    = "${var.project}-${var.enviroment}-public-rt"
    "Project" = var.project
    "Env"     = var.enviroment
    "Type"    = "public"
  }
}

resource "aws_route_table_association" "public_rt-1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public-subnet-1a.id
}

resource "aws_route_table_association" "public_rt-1c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public-subnet-1c.id
}

# private
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name"    = "${var.project}-${var.enviroment}-private-rt"
    "Project" = var.project
    "Env"     = var.enviroment
    "Type"    = "private"
  }
}

resource "aws_route_table_association" "private_rt-1a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private-subnet-1a.id
}

resource "aws_route_table_association" "private_rt-1c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private-subnet-1c.id
}
