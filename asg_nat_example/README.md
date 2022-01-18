https://spin.atomicobject.com/2019/01/24/aws-nat-implicit-dependency/
https://github.com/arminc/terraform-ecs

https://max-ko.ru/43-terraform-aws-deploj-klastera-serverov-s-elastic-load-balancer.html

## Terraform modules 


иеррархия

шаблоны ресурсов
- nat_gw
- subnet
- vpc

модули инфраструктуры
- network
- ec2
- alb

Пока что-то не работает у меня система. Откатываьс до простой схемы 

LD -> instance into public_network

#1
https://lyalyuev.info/2018/03/18/packer-io/

#2

https://www.bogotobogo.com/DevOps/Terraform/Terraform-VPC-Subnet-ELB-RouteTable-SecurityGroup-Apache-Server-1.php

https://www.bogotobogo.com/DevOps/Terraform/Terraform-VPC-Subnet-ELB-RouteTable-SecurityGroup-Apache-Server-2.php

https://www.bogotobogo.com/DevOps/Terraform/Terraform-docker-nginx-alb-dynamic-autoscaling.php


###
https://hiveit.co.uk/techshop/terraform-aws-vpc-example/04-create-the-application-load-balancer/