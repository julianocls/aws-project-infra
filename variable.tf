# Variável para a região da AWS
variable "region" {
  description = "Região onde a instância será criada"
  type        = string
  default     = "us-east-1"
}

# Variável para a zona de disponibilidade (AZ) da AWS
variable "availability_zone_us-east-1a" {
  description = "Região onde a instância será criada"
  type        = string
  default     = "us-east-1a"
}


# Variável para a zona de disponibilidade (AZ) da AWS
variable "availability_zone_us-east-1b" {
  description = "Região onde a instância será criada"
  type        = string
  default     = "us-east-1b"
}

# Variável para o tipo da instância
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

# AMI instancia EC2
variable "ami" {
  description = "AMI da Instância EC2"
  type = string
  default = "ami-0166fe664262f664c"
}

# Username Postgres
variable "db_username_postgres" {
  type      = string
  sensitive = true
}

# Password Postgres
variable "db_password_postgres" {
  type      = string
  sensitive = true
}
