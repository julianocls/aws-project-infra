# Criar uma VPC
resource "aws_vpc" "aws-project-main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

# Criar uma Sub-rede
resource "aws_subnet" "aws-project-main_subnet" {
  vpc_id            = aws_vpc.aws-project-main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Modifique conforme sua região
  tags = {
    Name = "main-subnet"
  }
}

# Criar um Gateway de Internet para acesso público
resource "aws_internet_gateway" "aws-project-main_igw" {
  vpc_id = aws_vpc.aws-project-main_vpc.id
  tags = {
    Name = "main-igw"
  }
}

# Associar uma rota ao Gateway de Internet
resource "aws_route_table" "aws-project-main_rt" {
  vpc_id = aws_vpc.aws-project-main_vpc.id
  tags = {
    Name = "main-route-table"
  }
}

# Definir uma rota para o tráfego de saída
resource "aws_route" "aws-project-default_route" {
  route_table_id         = aws_route_table.aws-project-main_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws-project-main_igw.id
}

# Associar a tabela de roteamento a uma sub-rede
resource "aws_route_table_association" "aws-project-subnet_association" {
  subnet_id      = aws_subnet.aws-project-main_subnet.id
  route_table_id = aws_route_table.aws-project-main_rt.id
}

# Criar um Grupo de Segurança para a EC2
resource "aws_security_group" "aws-project-ec2_sg" {
  vpc_id = aws_vpc.aws-project-main_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["127.0.0.1/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2-sg"
  }
}
