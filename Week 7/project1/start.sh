#!/bin/bash
sudo apt update -y
sudo apt-get update
sudo apt-get -y upgrade
sudo apt install python3
sudo apt install git
git clone https://github.com/iampsrv/aws-flask.git
cd aws-flask
sudo apt-get -y install python3-pip
pip install flask --break-system-packages
pip install boto3 --break-system-packages
python3 app.py