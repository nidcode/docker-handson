resource "aws_vpc" "this" {
  cidr_block = var.vpc.cidr
  tags = {
    Name = var.vpc.name
  }
}

resource "aws_subnet" "public" {
  count             = length(var.vpc.subnets.pub)
  vpc_id            = aws_vpc.this.id
  cidr_block        = values(var.vpc.subnets.pub)[count.index].cidr
  availability_zone = values(var.vpc.subnets.pub)[count.index].availability_zone
  tags = {
    Name = "${var.vpc.name}_pub_${keys(var.vpc.subnets.pub)[count.index]}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc.name}_igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.vpc.name}_rt_pub"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.vpc.subnets.pub)
  subnet_id      = element(aws_subnet.public, count.index).id
  route_table_id = aws_route_table.public.id
}