#!/bin/bash

set -x

token=$(kubectl describe secrets default-token-84hl9 | grep ^token | cut -f7 -d ' ')

if [ -z $token ];then
    echo "token is empty!"
    tail -n 1
    exit 1
fi

curl $1 --header "Authorization: Bearer $token" -k 
