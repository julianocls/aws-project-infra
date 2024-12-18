# Configura instancia EC2
resource "aws_instance" "aws-project-ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.aws-project-main_subnet_1.id
  key_name      = aws_key_pair.ec2_key_pair.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.aws-project_security_group.id
  ]
  tags = {
    Name = "aws-project-ec2"
  }
}

