data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_iam_role" "ssm" {
  name = "AmazonSSMRoleForInstancesQuickSetup"
}

resource "aws_security_group" "docker" {
  name        = "handson_docker"
  description = "Allow 8080 inbound traffic for handson"
  vpc_id      = aws_vpc.this.id

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all_8080"
  }
}

resource "aws_instance" "docker" {
  count                       = length(var.users)
  ami                         = data.aws_ami.ecs.id
  instance_type               = var.ec2.instance.type
  vpc_security_group_ids      = [aws_vpc.this.default_security_group_id, aws_security_group.docker.id]
  iam_instance_profile        = data.aws_iam_role.ssm.name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.0.id
  tags = {
    Name = element(var.users, count.index)
  }
}

output "public_ip_addresses" {
  value = {
    for instance in aws_instance.docker :
    instance.tags.Name => instance.public_ip
  }
}