# # Cria o subnet_group para o RDS
# resource "aws_db_subnet_group" "main" {
#   name       = "aws-project-main-subnet-group"
#   subnet_ids = aws_subnet.main[*].id
#
#   tags = {
#     Name = "aws-project-main-subnet-group"
#   }
# }
#
# # Cria o banco de dados postgres
# resource "aws_db_instance" "postgres" {
#   allocated_storage       = 20
#   storage_type           = "gp2"
#   engine                 = "postgres"
#   engine_version         = "16.3"
#   instance_class         = "db.t4g.micro"
#   db_name                = "postgresdb"
#   username               = "postgres"
#   password               = var.db_password_postgres
#   db_subnet_group_name   = aws_db_subnet_group.main.name
#   vpc_security_group_ids = [aws_security_group.postgres.id]
#   publicly_accessible    = true
#
#   tags = {
#     Name = "postgres-db"
#   }
# }
