# Variável para a região da AWS
variable "region" {
  description = "Região onde a instância será criada"
  type        = string
  default     = "us-east-1"
}

# Variável para a zona de disponibilidade (AZ) da AWS
variable "availability_zone" {
  description = "Região onde a instância será criada"
  type        = string
  default     = "us-east-1a"
}

# Variável para o tipo da instância
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI da Instância EC2"
  type = string
  default = "ami-0166fe664262f664c"
}