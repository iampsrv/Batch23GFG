resource "aws_instance" "ansible" {
  ami                         = "ami-04a81a99f5ec58529"
  instance_type               = "t2.micro"
  key_name                    = "batch23"
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt-get update
              sudo apt-get -y upgrade
              sudo apt install software-properties-common
              sudo apt-add-repository -y ppa:ansible/ansible
              sudo apt update
              sudo apt install ansible -y
              EOF

  tags = {
    Name = "ansible-master-tf"
  }
}
