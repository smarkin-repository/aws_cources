#!/bin/bash

export PATH=$PATH:/usr/bin
apt-get update
apt-get -y install nginx
ufw allow 'Nginx HTTP'
ufw allow 'Nginx HTTPS'
ufw allow 'OpenSSH'
echo "y" | sudo ufw enable

adduser ec-user --disabled-login --gecos ""
usermod -aG sudo ec-user
rsync --archive --chown=ec-user:ec-user ~/.ssh /home/ec-user