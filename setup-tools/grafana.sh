#sudo yum update -y
file_path="/etc/yum.repos.d/grafana.repo"
lines="[grafana]\nname=grafana\nbaseurl=https://packages.grafana.com/oss/rpm\nrepo_gpgcheck=1\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.grafana.com/gpg.key\nsslverify=1\nsslcacert=/etc/pki/tls/certs/ca-bundle.crt"
echo -e "$lines" | sudo tee -a $file_path > /dev/null
sudo yum install grafana -y
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service
