#!/bin/bash
sudo apt-add-repository
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties
sudo apt-get install -y build-essential python-dev
sudo apt-get build-dep -y python-imaging
sudo apt-get install -y nginx git curl ntp wget sysstat
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
