#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y ssh python3 wget curl
echo "codespace:admin123" | sudo chpasswd
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service ssh start
echo "UBUNTU SYSTEM READY."
