# Criar uma VPC com suporte a DNS
resource "aws_vpc" "aws-project-main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Criar uma Sub-rede 1
resource "aws_subnet" "aws-project-main_subnet_1" {
  vpc_id                  = aws_vpc.aws-project-main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zone_us-east-1a
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet-1"
  }
}

# Criar uma Sub-rede 2
resource "aws_subnet" "aws-project-main_subnet_2" {
  vpc_id                  = aws_vpc.aws-project-main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.availability_zone_us-east-1b
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet-2"
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

# Associar a tabela de roteamento a Sub-rede 1
resource "aws_route_table_association" "aws-project-subnet_1_association" {
  subnet_id      = aws_subnet.aws-project-main_subnet_1.id
  route_table_id = aws_route_table.aws-project-main_rt.id
}

# Associar a tabela de roteamento a Sub-rede 2
resource "aws_route_table_association" "aws-project-subnet_2_association" {
  subnet_id      = aws_subnet.aws-project-main_subnet_2.id
  route_table_id = aws_route_table.aws-project-main_rt.id
}

# Criar um Grupo de Segurança para a EC2
resource "aws_security_group" "aws-project_security_group" {
  vpc_id = aws_vpc.aws-project-main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# Criar um Grupo de Segurança para permitir conexões ao PostgreSQL
resource "aws_security_group" "allow_postgres" {
  name_prefix  = "allow-postgres"
  description  = "Allow PostgreSQL traffic"
  vpc_id       = aws_vpc.aws-project-main_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
