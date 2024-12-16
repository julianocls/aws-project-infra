resource "aws_instance" "aws-project-ec2" {
  ami = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.aws-project-main_subnet.id
  vpc_security_group_ids = [
    aws_security_group.aws-project-ec2_sg.id
  ]
  tags = {
    Name = "aws-project-ec2"
  }
}