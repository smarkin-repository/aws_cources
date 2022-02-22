#!/bin/bash 

set -o pipefail

# https://stackoverflow.com/questions/70926799/centos-through-vm-no-urls-in-mirrorlist
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

