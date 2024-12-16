resource "aws_instance" "aws-project-ec2" {
  ami = "ami-0166fe664262f664c"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.aws-project-main_subnet.id
  key_name      = aws_key_pair.ec2_key_pair.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.aws-project-ec2_sg.id
  ]
  tags = {
    Name = "aws-project-ec2"
  }
}

