# Cria o subnet_group
resource "aws_db_subnet_group" "aws-project-main_subnet_group" {
  name       = "aws-project-main-subnet-group"
  subnet_ids = [
    aws_subnet.aws-project-main_subnet_1.id, aws_subnet.aws-project-main_subnet_2.id
  ]
}

# Cria o banco de dados postgres
resource "aws_db_instance" "aws-project_postgres" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "16.3"
  instance_class = "db.t4g.micro"
  db_name = "postgresdb"
  username = var.db_username_postgres
  password = var.db_password_postgres
  db_subnet_group_name = aws_db_subnet_group.aws-project-main_subnet_group.name
  vpc_security_group_ids = [aws_security_group.allow_postgres.id]
  publicly_accessible = true
}