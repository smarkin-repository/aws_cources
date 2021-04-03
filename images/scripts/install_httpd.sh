#! /bin/bash


sudo yum update
sudo yum install -y httpd
# chkconfig httpd on
# service httpd start
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html