variable "image_id" {
  type = string
  default = "ami-04b70fa74e45c3917"
}

resource "aws_instance" "web" {
  ami = var.image_id
  #data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.mysubnet2.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  user_data       = file("start.sh")
  # availability_zone           = "us-east-1a"

  tags = {
    Name = "ec2instance"
  }
}

resource "aws_instance" "web1" {
  ami = var.image_id
  #data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.mysubnet1.id
  vpc_security_group_ids = [aws_security_group.mysg.id]
  user_data       = file("start.sh")
  # availability_zone           = "us-east-1a"

  tags = {
    Name = "ec2instance-new"
  }
}