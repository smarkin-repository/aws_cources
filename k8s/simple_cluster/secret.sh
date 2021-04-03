#!/bin/bash

set -ex

TOKEN=$(aws ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken')

kubectl create secret docker-registry regcred \
--docker-server=500480925365.dkr.ecr.eu-north-1.amazonaws.com/simple_app \
--docker-username=AWS \
--docker-password=$TOKEN \
--docker-email=ssmarkin.it@gmail.com