# Gera o par de chaves RSA
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Cria o Key Pair no AWS utilizando a chave pública gerada
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# Salva a chave privada no diretório ~/.ssh
resource "local_file" "private_key" {
  filename = "${path.module}/ec2-key.pem"
  content  = tls_private_key.ec2_key.private_key_pem
  #sensitive = true
}

# Usa um provisioner local-exec para mover o arquivo para ~/.ssh/
resource "null_resource" "move_private_key" {
  depends_on = [local_file.private_key]  # Garante que o arquivo seja gerado antes de mover

  provisioner "local-exec" {
    command = "mv ${path.module}/ec2-key.pem ~/.ssh/ec2-key.pem"
  }
}

# Exibe a chave privada como saída (mas não será exibida no terminal devido ao "sensitive = true")
output "private_key" {
  value     = local_file.private_key.content
  sensitive = true
}
