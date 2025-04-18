terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.87.0"
    }
  }
}

# Criando o Bucket S3
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tf-docker-eliezerpires"
}
# Ativando o versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket_versioning.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}

# Create a VPC
resource "aws_vpc" "vpc_docker_learn" {
  cidr_block = "10.116.0.0/16"
}

resource "aws_subnet" "ec2_docker_subnet" {
  vpc_id                  = aws_vpc.vpc_docker_learn.id
  cidr_block              = "10.116.40.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}

resource "aws_key_pair" "ec2_docker_key" {
  key_name   = "ec2-docker-aws"
  public_key = file("~/.ssh/ec2-docker-aws.pub")
}

# Criar Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_docker_learn.id

  tags = {
    Name = "InternetGateway-Docker"
  }
}

# Criar Tabela de Rotas Pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_docker_learn.id

  tags = {
    Name = "Public Route Table"
  }
}

# Criar Rota na Tabela de Rotas Pública para acessar a Internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Associar a Tabela de Rotas à Subnet Pública
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.ec2_docker_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "ec2_webserver" {
  name        = "ec2-webserver"
  description = "Permite acesso via porta 80, HTTP"
  vpc_id      = aws_vpc.vpc_docker_learn.id

  # Regra para permitir porta 80 http
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Regra para permitir saída para meu ip
  egress {
    description = "Saida Irrestrita"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-webserver"
  }
}

resource "aws_security_group" "ec2_dk_ssh_ping" {
  name        = "ec2-dk-ssh-ping"
  description = "Permite SSH e ICMP para a instancia EC2"
  vpc_id      = aws_vpc.vpc_docker_learn.id # Usa a vpc criada anteriormente

  # Regra para permitir SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra para permitir ping (ICMP Echo Request)
  ingress {
    description = "Ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra para permitir saída para meu ip
  egress {
    description = "Saida Irrestrita"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-ssh-ping"
  }
}

resource "aws_instance" "ec2_docker_learning" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.ec2_docker_subnet.id         # Especificando a subnet
  vpc_security_group_ids      = [aws_security_group.ec2_dk_ssh_ping.id] # Associação com o SG
  key_name                    = "ec2-docker-aws"
  associate_public_ip_address = true # Nome do Key Pair criado na AWS

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install docker -y
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user
    sleep 10
    echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    docker run -d --name meu-nginx -p 80:80 nginx
    docker ps > /tmp/docker-ps.log
    ss -tunlp > /tmp/ports.log
    EOF

  tags = {
    Name = "Ec2-Docker-learning-fedora"
  }
}
