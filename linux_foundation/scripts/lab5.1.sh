#!/bin/bash 

set -x

cert_name="/home/devops/.minikube/profiles/minikube/client.crt"
client_key="/home/devops/.minikube/profiles/minikube/client.key"
ca_cert="/home/devops/.minikube/ca.crt"
server="https://127.0.0.1:3421"

cmd="curl --cert $cert_name --key $client_key --cacert $ca_cert $server/$1"

$cmd
