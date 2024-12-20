# Configura instância EC2
resource "aws_instance" "aws_project_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main[0].id
  key_name                    = aws_key_pair.ec2_key_pair.key_name
  associate_public_ip_address = true

  # Usando o grupo de segurança 'ec2' da VPC
  vpc_security_group_ids = [aws_security_group.ec2.id]
  tags = {
    Name = "aws-project-ec2"
  }

  # Adicionando tags para gerenciar e identificar a instância
  lifecycle {
    create_before_destroy = true
  }
}
