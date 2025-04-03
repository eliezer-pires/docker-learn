
# Criando EC2 
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*"] # Amazon Linux 2023
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }


  filter {
    name   = "architecture"
    values = ["x86_64"] # Para processadores Intel/AMD
  }

  owners = ["137112412989"] # AWS ID oficial para Amazon Linux
}

data "aws_vpc" "ec2_docker_subnet" {
  default = true
}