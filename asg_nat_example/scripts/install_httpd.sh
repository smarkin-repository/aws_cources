#! /bin/bash
sudo su

yum update
yum install -y httpd
# chkconfig httpd on
# service httpd start
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html