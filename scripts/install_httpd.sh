#! /bin/bash

sudo su
yum update -y
yum install -y httpd
# chkconfig httpd on
# service httpd start
systemctl enable httpd.service
systemctl start httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html
curl localhost