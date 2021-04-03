https://spin.atomicobject.com/2019/01/24/aws-nat-implicit-dependency/
https://github.com/arminc/terraform-ecs
https://max-ko.ru/43-terraform-aws-deploj-klastera-serverov-s-elastic-load-balancer.html

## Terraform modules 

шаблоны ресурсов
- nat_gw
- subnet
- vpc

модули инфраструктуры
- network
- ec2
- alb


[+] base infra: LD -> instance into public_network

#1 
https://lyalyuev.info/2018/03/18/packer-io/

#2 

https://www.bogotobogo.com/DevOps/Terraform/Terraform-VPC-Subnet-ELB-RouteTable-SecurityGroup-Apache-Server-1.php

https://www.bogotobogo.com/DevOps/Terraform/Terraform-VPC-Subnet-ELB-RouteTable-SecurityGroup-Apache-Server-2.php

[+] Autoscaling
#3 
https://www.bogotobogo.com/DevOps/Terraform/Terraform-docker-nginx-alb-dynamic-autoscaling.php


###
https://hiveit.co.uk/techshop/terraform-aws-vpc-example/04-create-the-application-load-balancer/

[+] ### Private Destination 

https://letslearndevops.com/2017/07/24/how-to-create-a-vpc-with-terraform/

[+] ### terratest
обновить тесты на создание ресурсов

[+] ### R53
создать запись и назначить lb

### SSL
генерация и подготвка сертификатов
- написать пошаговый подход
? как избежать настройки севрере на 443 порт?
или надо 80 -> 443. 


### DATABASE
создать базу данных private db network и потестировать из ec2 в private zone
на чтение/запись.
как потестировать из сервера?
connect to SQL
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToPostgreSQLInstance.html

### S3 bucket

создать базу данных private db network и потестировать из ec2 в private zone
на чтение/запись.

### aws pipeline prepare ami 
сборка образа и публикация на aws.
поиск образ через фильтр. 

# проект мой дом - taloni - market placessss

## Мой demo Web Project

1) сервис nextcloud
2) закрузка файлов 
3) отображение файлов
в определенном формате.



