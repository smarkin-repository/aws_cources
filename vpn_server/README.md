# ssh


# Ansible

проверить файл инвентаризации
> ansible-inventory --list -y -i ./ansible/hosts


> ansible all -m ping -u ec-user -i ./ansible/hosts
> ansible <name_server> -m ping -u ec-user -i ./ansible/hosts

> ansible vpn_server -m shell -a "echo 'Hello!'" -u ec-user -i ./ansible/hosts
```
vpn_server | CHANGED | rc=0 >>
Hello!
```

> ansible-playbook -i hosts main.yml

# 
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04-ru

https://www.digitalocean.com/community/cheatsheets/how-to-use-ansible-cheat-sheet-guide



# https://www.digitalocean.com/docs/monitoring/how-to/install-agent/
Настроить мониторинг

# VPN 
- разобраться с сертификатами
- поднять серт центр
- обновить пароли и политику 