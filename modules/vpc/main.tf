resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    Environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.vpc_name}-public-rt"
    Environment = var.environment
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.vpc_name}-private-rt"
    Environment = var.environment
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
  }

}
resource "aws_subnet" "public" {
  for_each = local.public_subnet_map
  vpc_id   = aws_vpc.main.id

  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.vpc_name}-public-${each.key}"
    Environment = var.environment
  }

}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_map
  vpc_id   = aws_vpc.main.id

  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    Name        = "${var.vpc_name}-private-${each.key}"
    Environment = var.environment
  }

}
resource "aws_eip" "nat" {
  associate_with_private_ip = null
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[local.public_subnet_map_keys[0]].id
  tags = {
    Name        = "${var.vpc_name}-nat"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public" {
  for_each       = local.public_subnet_map
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id

}
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
resource "aws_route_table_association" "private" {
  for_each       = local.private_subnet_map
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id

}