resource "aws_instance" "nodeexp" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "batch19"
  vpc_security_group_ids      = [aws_security_group.ecs_security_group.id]
  subnet_id                   = aws_subnet.subnet1.id
  associate_public_ip_address = true
  user_data                   = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt-get update
sudo apt-get -y upgrade
cd /opt
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
sudo tar xf node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
sudo ./node_exporter
              EOF

  tags = {
    Name = "node-exporter-tf"
  }
}



