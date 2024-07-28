resource "aws_instance" "web1" {
  ami                         = var.ami_id_mod
  instance_type               = var.instance_type_mod
  associate_public_ip_address = true
  vpc_security_group_ids             = [aws_security_group.mysg.id]
  tags = {
    Name = var.name
  }
}

variable "instance_type_mod" {
#   default = "t2.micro"
#   type    = string
}

variable "ami_id_mod" {
#   default = "ami-0f5ee92e2d63afc18"
#   type    = string
}

variable "name" {
#   default = "myec2mod"
#   type    = string
}

variable "name_sg" {
#   default = "myec2mod"
#   type    = string
}

resource "aws_security_group" "mysg" {
  name        = var.name_sg
  description = "Created by terraform"
#   vpc_id      = aws_vpc.vpctf.id

  ingress {
    description = "Custom Tcp"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name_sg
  }
}