#!/bin/bash
sudo apt update -y
sudo apt install -y gnupg software-properties-common
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install -y openjdk-17-jdk jenkins
sudo apt install python3-pip
sudo systemctl enable jenkins
sudo systemctl start jenkins