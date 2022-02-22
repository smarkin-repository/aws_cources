#!/bin/bash 

set -o pipefail

cp -r /vagrant/data/.vimrc /home/vagrant/


# https://stackoverflow.com/questions/64120030/hash-sum-mismatch-when-apt-get-update-ubuntu-20-04-vm-with-multipass
mkdir /etc/gcrypt
echo all >> /etc/gcrypt/hwf.deny
apt-get update