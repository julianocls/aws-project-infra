# Configura key pair
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# Tipo algoritimo da chave
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Configura de saida da chave
output "private_key" {
  value     = tls_private_key.ec2_key.private_key_pem
  sensitive = true
}
