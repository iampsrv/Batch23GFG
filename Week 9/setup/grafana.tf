resource "aws_instance" "example" {
  ami           = "ami-08a52ddb321b32a8c"
  instance_type = "t2.micro"
  subnet_id              = aws_subnet.subnet1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ecs_security_group.id]
  key_name                    = "batch19"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              file_path="/etc/yum.repos.d/grafana.repo"
              lines="[grafana]\\nname=grafana\\nbaseurl=https://packages.grafana.com/oss/rpm\\nrepo_gpgcheck=1\\nenabled=1\\ngpgcheck=1\\ngpgkey=https://packages.grafana.com/gpg.key\\nsslverify=1\\nsslcacert=/etc/pki/tls/certs/ca-bundle.crt"
              echo -e "$lines" | sudo tee -a $file_path > /dev/null
              sudo yum install grafana -y
              sudo systemctl daemon-reload
              sudo systemctl start grafana-server
              sudo systemctl enable grafana-server.service
              EOF

  tags = {
    Name = "grafana-instance"
  }
}